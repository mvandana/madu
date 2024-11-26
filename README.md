
# Candidate Progress Tracking Procedure

## **Overview**

This repository contains a stored procedure, `usp_TrackCandidateProgress`, designed to support the Council on Teacher Education (CoTE) in monitoring licensure progress for candidates across multiple programs. The procedure automates the tracking and reporting of candidate progress, identifies those at risk of non-compliance, and generates detailed reports for faculty and administrators.

---

## **Key Features**

1. **Dynamic Progress Tracking**:
   - Calculates candidates’ progress by comparing completed requirements to total program requirements.
   - Flags candidates with incomplete requirements and identifies missing components.

2. **Automated Reporting**:
   - Generates an HTML-formatted report for easy readability.
   - Prints the report for quick verification.

3. **Proactive Risk Management**:
   - Ensures compliance with licensure requirements by identifying and addressing gaps early.

4. **Ease of Use**:
   - Includes a single SQL setup script for seamless deployment.

---

## **Technology Used**

- **SQL**: For database operations, data aggregation, and dynamic HTML report generation.
- **Dynamic HTML**: Generates user-friendly, actionable reports.

---

## **How to Run the Code**

### **1. Prerequisites**
- Install **Microsoft SQL Server** (Express or Standard) and **SQL Server Management Studio (SSMS)**.
- Ensure your system has permissions to create and modify databases.

---

### **2. Setup Instructions**

#### **Step 1: Clone the Repository**
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/mvandana/madu.git
   cd madu
   ```

#### **Step 2: Run the Setup Script**
1. Open `setup.sql` in SQL Server Management Studio (SSMS).
2. Execute the script to:
   - Create the `TestCoTE` database.
   - Create the required tables (`candidates`, `licensure_requirements`, and `candidate_requirements`).
   - Insert sample data.
   - Deploy the `usp_TrackCandidateProgress` stored procedure.

#### **Step 3: Execute the Stored Procedure**
1. In SSMS, run the following command to execute the stored procedure:
   ```sql
   EXEC usp_TrackCandidateProgress;
   ```
2. **Expected Output**:
   - An HTML report summarizing candidate progress will be printed in the SSMS output.

---

## **Why This Matters**

This project showcases:
- Expertise in SQL for data management, reporting, and automation.
- Practical solutions to improve compliance and efficiency in educational workflows.
- An ability to design scalable and maintainable systems for real-world applications.

---

### **File Structure**
- `Setup.sql`: A single script to set up the database, tables, sample data, and stored procedure.
- `README.md`: This file, detailing project functionality and usage instructions.

---

Feel free to share feedback or suggestions! If you encounter any issues, please open an issue in this repository.
