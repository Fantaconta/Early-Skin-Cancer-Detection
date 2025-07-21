# SQL-Driven Skin Cancer Risk Analysis

A comprehensive SQL-based analysis examining patient demographics, lifestyle factors, and lesion characteristics to identify key patterns associated with malignant skin lesions. This study provides data-driven insights to support early detection and improve clinical decision-making in dermatological care.

## Problem Statement
Skin cancer detection faces significant delays due to diagnostic challenges and incomplete understanding of risk factors including patient demographics, lifestyle behaviors, and lesion characteristics. Early identification of high-risk patterns can improve treatment outcomes and survival rates through timely medical intervention.

## Project Objectives
- Integrate patient demographic data with lesion characteristics for comprehensive risk analysis
- Identify demographic and lifestyle risk factors that correlate with malignant lesions
- Examine lesion features to distinguish patterns indicating malignant vs benign conditions
- Support clinical research by providing structured datasets for diagnostic improvement and AI model development

## Methodology
- Patient information and lesion data tables were imported into SQL database environment
- Comprehensive data quality validation performed to ensure analytical reliability
- SQL queries developed to explore dataset characteristics and relationships
- Six lesion types categorized into binary classification: benign (non-cancerous) vs malignant (cancerous)
- All statistical analysis conducted using this simplified classification system



## Database Schema
The analysis utilizes a relational database structure showing clear relationships between patient demographics, lesion characteristics, and clinical outcomes.



## Key Findings and Insights

### Age-Related Risk Patterns
Age emerged as a critical risk factor, with malignancy rates increasing significantly among older patients. This supports implementing age-stratified screening protocols with enhanced monitoring for elderly populations.



### Lifestyle Factor Impact
Despite representing minorities in the dataset, patients with lifestyle risk factors showed alarming malignancy rates:
- **Smoking patients:** 97% malignancy rate
- **Alcohol consumption:** 95% malignancy rate  
- **Combined smoking and drinking:** 100% malignancy rate

These findings indicate lifestyle factors as powerful predictors requiring intensive screening protocols.


### Lesion Size Correlation
Malignant lesions demonstrated significantly larger average diameter (5.89mm) compared to benign lesions. Female patients showed higher proportions of large lesions than males, suggesting gender-specific risk considerations for screening prioritization.


### Symptom-Based Assessment
A symptom scoring system using lesion characteristics (itching, bleeding, irregular borders) revealed increasing malignancy rates with higher symptom counts. However, 71% of asymptomatic cases were malignant, emphasizing that symptom absence doesn't exclude cancer risk.

This scoring system enables objective triage while highlighting limitations of symptom-only screening approaches.



### Family History Significance
Strong correlations emerged between family medical history and malignancy risk:
- **General family cancer history:** 92% malignancy rate
- **Previous personal skin cancer:** 93% malignancy rate
- **Both risk factors present:** 95% malignancy rate

These factors demonstrate strong predictive value for malignancy assessment.



### Skin Type Analysis
Fitzpatrick scale analysis confirmed that lighter skin types (Types I-II) exhibited higher malignancy percentages, supporting established research on melanin protection against UV radiation damage.


### High-Risk Profile Development
Analysis identified top 10 patient profiles combining multiple risk factors most associated with malignant lesions, enabling targeted screening and prevention strategies.



## Conclusions
This project demonstrates SQL's effectiveness in uncovering critical patterns for skin cancer early detection. By integrating patient demographics, lifestyle factors, lesion characteristics, and skin type data, the analysis identified high-risk groups and predictive malignancy markers. These insights validate established clinical knowledge while contributing to data-driven strategies for improved triage, diagnosis, and targeted public health interventions.

The structured approach provides a foundation for evidence-based screening protocols and supports clinical decision-making through quantified risk assessment.

## Future Development
- Implement machine learning models using identified features (age, lesion size, symptoms, skin type, lifestyle factors) to create predictive algorithms for skin cancer risk assessment
- Expand analysis to include additional variables such as geographic location, seasonal patterns, and occupational risk factors
- Develop clinical decision support tools for real-time risk assessment in healthcare settings

