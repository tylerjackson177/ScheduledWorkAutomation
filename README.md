# 📋 Scheduled Work Automation Workflow

## Overview

This project outlines a **paperless, automated workflow** for handling work visit submissions by field technicians. The system leverages **Google Forms**, **Google Sheets**, **Zapier**, and **Microsoft Access (VBA)** to create a seamless end-to-end process that eliminates manual paperwork and improves data accuracy and reporting speed.

---

## 🚀 Objectives

- Eliminate the need for physical service paperwork  
- Automate the ingestion of technician-submitted data  
- Maintain compatibility with our internal Microsoft Access system  
- Improve operational efficiency and audit readiness  

---

## 🔄 Workflow Summary

### 1. 🧾 Technician Submission via Google Form

Technicians submit a digital report using a **Google Form** immediately after completing a job. The form includes:

- Work performed  
- Future Work Needed  
- Job Result  
- Installation Photos  
- Paperwork Photos  
- Follow-up needs  

> ✅ **Paperless Efficiency**: No need for technicians to carry or submit paper forms.

---

### 2. ✉️ Job Assignment Emails with Prefilled Forms

A **stored procedure** was developed to generate and email a prefilled Google Form link when a technician is assigned a scheduled job. The link includes preloaded data such as:

- Job ID  
- Customer Name  
- Scheduled Date  
- Assigned Technician  

This ensures that when a technician opens the form, they only need to fill out their observations and upload supporting materials.

> ✅ **Automation Highlight**: Form is ready-to-use with job details, minimizing technician input time and errors.

---

### 3. 📊 Google Sheet as the Data Hub

Form responses are automatically logged in a connected **Google Sheet**, serving as the live data hub.

> ✅ **Live Data**: Centralized and real-time view of all service reports.

---

### 4. ⚙️ Zapier Automation – The Integration Layer

We used **Zapier** to bridge Google Sheets and Microsoft Access. The Zapier workflow is as follows:

- **Trigger**: New response added to the Google Sheet  
- **Action**: Data is sent to the SQL database  
- **Result**: Microsoft Access processes the incoming data via a VBA script and inserts it into the front end on form load  

> ✅ **No Manual Entry**: Data flows automatically—no one touches a keyboard after the form is submitted.

---

### 5. 🗃 Microsoft Access – Internal Operations

Data received via Zapier is automatically processed by Access using a custom **VBA module**, which:

- Validates and formats the data  
- Appends it to the front-end table  
- Triggers any downstream reporting or audit logic  

---

## 📈 Benefits

| Feature                         | Benefit                                                      |
|----------------------------------|---------------------------------------------------------------|
| ✅ 100% Paperless Workflow       | No more lost paperwork or manual submissions                 |
| ✅ Real-Time Ingestion           | Records appear in Access within minutes                      |
| ✅ Tech Productivity Boost       | No need to return to the office to submit reports            |
| ✅ Improved Data Quality         | Standardized input fields via Google Form                    |
| ✅ Scalable and Maintainable     | Easily update forms or automations without system downtime   |
| ✅ Prefilled Form Distribution   | Technicians receive context-ready forms at assignment time   |

---

## 💡 Why This Matters

This automation was built with one clear goal: **bring field data into the office without friction**. It's fast, efficient, and scalable. Technicians can focus on work—not paperwork—and back-office operations are faster and more reliable.

---

## 🔧 Technologies Used

- [Google Forms](https://www.google.com/forms/about/)  
- [Google Sheets](https://www.google.com/sheets/about/)  
- [Zapier](https://zapier.com/)  
- [Microsoft Access (VBA)](https://learn.microsoft.com/en-us/office/vba/api/overview/access)  
- SQL Server (for stored procedures and integration logic)

---

## 👨‍💻 Author

This solution and its automation architecture were built by **Tyler Jackson**, with a focus on reducing manual processes and bringing the operation fully into the digital age.

---

## 📄 License

[MIT](LICENSE)
