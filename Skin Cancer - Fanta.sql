 ---SKIN CANCER QUERIES

 ---PRELIMINARY QUERIES

  SELECT *FROM table1

--How does Gender and Age affects the type of skin lesion?
 SELECT table1.patient_id, table1.age, table1.gender, 
 table2.diagnostic, table2.biopsed
 FROM table1 JOIN table2 ON 
 table1.patient_id=table2.patient_id;

--How does ALCOHOL CONSUMPTION and SMOKING affects the type of skin lesion?
SELECT t1.patient_id, t1.drink, t1.smoke,
t2.diagnostic, t2.biopsed
FROM table1 t1 JOIN table2 t2 ON
t1.patient_id=t2.patient_id;

--How does demographic factors affect the type of skin lesion? 18)
SELECT t1.patient_id, t1.age, t1.gender, t1.drink, t1.smoke,
t1.background_father, t1.background_mother, t1.cancer_history, t1.skin_cancer_history,
t2.diagnostic, t2.biopsed, t2.region
FROM table1 t1 JOIN table2 t2 ON
t1.patient_id=t2.patient_id;


 --How does Environmental factors affect the type of skin lesion? 17)
SELECT t1.patient_id, t1.has_piped_water, t1.has_sewage_system, t1.pesticide,
t2.diagnostic, t2.biopsed, t2.region
FROM table1 t1 JOIN table2 t2 ON
t1.patient_id=t2.patient_id;


SELECT DISTINCT diagnostic FROM table2;

--Distribution of table based on their diagnostic types 
SELECT t1.patient_id, t2.diagnostic, 
CASE
     WHEN t2.diagnostic = 'NEV' THEN 'Benign'
     WHEN t2.diagnostic = 'BCC' THEN 'Malignant'
     WHEN t2.diagnostic = 'SEK' THEN 'Benign'
     WHEN t2.diagnostic = 'ACK' THEN 'Malignant'
     WHEN t2.diagnostic = 'SCC' THEN 'Malignant'
	 WHEN t2.diagnostic = 'MEL' THEN 'Malignant'
     ELSE 'Unknown'
 END AS Diagnostic_type
 FROM table1 t1 JOIN table2 t2 ON
 t1.patient_id=t2.patient_id;



--What is the number of people with Malignant type and the number of people with Benign?
SELECT COUNT (t1.patient_id) AS total_count, t2.diagnostic, 
CASE
     WHEN t2.diagnostic = 'NEV' THEN 'Benign'
     WHEN t2.diagnostic = 'BCC' THEN 'Malignant'
     WHEN t2.diagnostic = 'SEK' THEN 'Benign'
     WHEN t2.diagnostic = 'ACK' THEN 'Malignant'
     WHEN t2.diagnostic = 'SCC' THEN 'Malignant'
	 WHEN t2.diagnostic = 'MEL' THEN 'Malignant'
     ELSE 'Unknown'
 END AS Diagnostic_type
 FROM table1 t1 JOIN table2 t2 ON
 t1.patient_id=t2.patient_id
 GROUP BY Diagnostic_type, t2.diagnostic
 ORDER BY total_count DESC;



SELECT 
    CASE
        WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
        WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
        ELSE 'Unknown'
    END AS Diagnostic_type,
    COUNT(*) AS total_count
FROM 
    table1 t1
JOIN 
    table2 t2 ON t1.patient_id = t2.patient_id
GROUP BY 
    CASE
        WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
        WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
        ELSE 'Unknown'
    END;


--what is the total number and percentage of people who have malignant and benign types respectively? 16)

SELECT 
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        0
    ) AS percentage
FROM (
    SELECT diagnostic,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY Diagnostic_type;

--whats the number and percentage of people (male and female) who have malignant and benign 15)
SELECT 
    gender,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY gender),
        2
    ) AS percentage
FROM (
    SELECT 
        t1.gender,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')  -- Only include known types
) AS sub
GROUP BY 
    gender, 
    Diagnostic_type;

-- an extra query for also analyzing lesions (diagnostic type) based on gender

SELECT gender, COUNT (*),
		COUNT(CASE WHEN diagnostic_type = 'benign' THEN 1 END) as benign_count,
		ROUND(
		100.0 * COUNT(CASE WHEN diagnostic_type = 'benign' THEN 1 END) / COUNT(*),0) AS benign_percentage,

		COUNT(CASE WHEN diagnostic_type = 'malignant' THEN 1 END) AS malignant_count,
		round(
		100.0 * COUNT(CASE WHEN diagnostic_type = 'malignant' THEN 1 END) / COUNT(*),0) AS malignant_percentage
		

FROM(
		SELECT gender,
		CASE
			WHEN diagnostic IN ('NEV', 'SEK') THEN 'benign'
			WHEN diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'malignant'
			ELSE 'unknown' END AS diagnostic_type
		FROM table1 t1 
JOIN table2 t2 ON t1.patient_id = t2.patient_id

WHERE diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub

GROUP BY gender;



--How smoking influences diagnostic type 14)

SELECT smoke, COUNT (patient_id)
FROM table1
GROUP BY smoke;

SELECT 
    smoke,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY smoke),
        0
    ) AS percentage
FROM (
    SELECT 
        t1.smoke,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    smoke, 
    Diagnostic_type;





--How alcohol consumption influences diagnostic type 13)

SELECT 
    drink,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY drink),
        0
    ) AS percentage
FROM (
    SELECT 
        t1.drink,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    drink, 
    Diagnostic_type;


--How pesticide influences diagnostic type 12)
	SELECT 
    pesticide,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY pesticide),
        0
    ) AS percentage
FROM (
    SELECT 
        t1.pesticide,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    pesticide, 
    Diagnostic_type;


	
--How has_sewage_system influences diagnostic type 11)
	SELECT 
    has_sewage_system,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY has_sewage_system),
        2
    ) AS percentage
FROM (
    SELECT 
        t1.has_sewage_system,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')  
) AS sub
GROUP BY 
    has_sewage_system, 
    Diagnostic_type;


--How pipe water influences diagnostic type 10)
		SELECT 
    has_piped_water,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY has_piped_water),
        2
    ) AS percentage
FROM (
    SELECT 
        t1.has_piped_water,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    has_piped_water, 
    Diagnostic_type;



--How skin cancer history influences diagnostic type 9)
	SELECT 
    skin_cancer_history,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY skin_cancer_history),
        2
    ) AS percentage
FROM (
    SELECT 
        t1.skin_cancer_history,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    skin_cancer_history, 
    Diagnostic_type;



--How cancer history influences diagnostic type 8)
    SELECT 
    cancer_history,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY cancer_history),
        2
    ) AS percentage
FROM (
    SELECT 
        t1.cancer_history,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY 
    cancer_history, 
    Diagnostic_type;


	
--How cancer background father influences diagnostic type
    SELECT 
    background_father,
    Diagnostic_type,
    COUNT(*) AS total_count
    
FROM (
    SELECT 
        t1.background_father,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') 
) AS sub
GROUP BY 
    background_father, 
    Diagnostic_type
	order by Total_count desc;



--How cancer background mother influences diagnostic type 
	    SELECT 
    background_mother,
    Diagnostic_type,
    COUNT(*) AS total_count
FROM (
    SELECT 
        t1.background_mother,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY 
    background_mother, 
    Diagnostic_type
	order by total_count desc;


Select distinct background_father from table1;


--How cancer Age influences diagnostic type 7)
SELECT 
    age_group,
    Diagnostic_type,
    COUNT(*) AS total_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY age_group),
        0
    ) AS percentage
FROM (
    SELECT 
        CASE 
            WHEN t1.age < 20 THEN '0-19'
            WHEN t1.age BETWEEN 20 AND 39 THEN '20-39'
            WHEN t1.age BETWEEN 40 AND 59 THEN '40-59'
            WHEN t1.age BETWEEN 60 AND 79 THEN '60-79'
            ELSE '80+' 
        END AS age_group,
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY 
    age_group, Diagnostic_type
ORDER BY 
    age_group, Diagnostic_type;




--Distribution by leision characteristics of each cancer type? 6)
	SELECT 
    Diagnostic_type,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN itch = true THEN 1 ELSE 0 END) AS "Itch",
    SUM(CASE WHEN grew = true THEN 1 ELSE 0 END) AS "Growth",
    SUM(CASE WHEN hurt = true THEN 1 ELSE 0 END) AS "Pain",
    SUM(CASE WHEN changed = true THEN 1 ELSE 0 END) AS "Changed",
    SUM(CASE WHEN bleed = true THEN 1 ELSE 0 END) AS "Bleed",
    SUM(CASE WHEN elevation = true THEN 1 ELSE 0 END) AS "Elevated",
    ROUND(AVG((diameter_1 + diameter_2)/2.0)::numeric, 2) AS avg_diameter
FROM (
    SELECT 
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type,
        t2.*
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY Diagnostic_type
ORDER BY total_lesions DESC;



--distribution based on biopsed to determine the diagnostic type 5)
SELECT 
    Diagnostic_type,
    COUNT(*) AS total_lesions,
    SUM(CASE WHEN biopsed = true THEN 1 ELSE 0 END) AS biopsed_count,
    SUM(CASE WHEN biopsed = false THEN 1 ELSE 0 END) AS not_biopsed_count,
    ROUND(
        100.0 * SUM(CASE WHEN biopsed = true THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS biopsed_percentage,
    ROUND(AVG((diameter_1 + diameter_2)/2.0)::numeric, 2) AS avg_diameter
FROM (
    SELECT 
        CASE
            WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 'Benign'
            WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 'Malignant'
            ELSE 'Unknown'
        END AS Diagnostic_type,
        t2.*
    FROM 
        table1 t1
    JOIN 
        table2 t2 ON t1.patient_id = t2.patient_id
    WHERE 
        t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
) AS sub
GROUP BY Diagnostic_type
ORDER BY total_lesions DESC;


--Distribution of diagnostic types based on region 4)
	SELECT 
    t2.region,
    COUNT(*) AS total_cases,
    COUNT(CASE 
        WHEN t2.diagnostic IN ('NEV', 'SEK') THEN 1 
        END) AS benign_count,
    COUNT(CASE 
        WHEN t2.diagnostic IN ('BCC', 'ACK', 'SCC', 'MEL') THEN 1 
        END) AS malignant_count
FROM 
    table1 t1
JOIN 
    table2 t2 ON t1.patient_id = t2.patient_id
WHERE 
    t2.diagnostic IN ('NEV', 'SEK', 'BCC', 'ACK', 'SCC', 'MEL')
GROUP BY 
    t2.region
ORDER BY 
    malignant_count DESC;



