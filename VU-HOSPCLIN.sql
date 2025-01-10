create database VU_HOSPCLIN;
Use VU_HOSPCLIN;
CREATE TABLE geographical_location (
    Location_ID INT PRIMARY KEY,
    Village VARCHAR(100),
    Parish VARCHAR(100),
    Sub_County VARCHAR(100),
    County VARCHAR(100),
    Region VARCHAR(50),
    Population INT,
    Coordinates VARCHAR(100),
    ITN_Coverage DECIMAL(5,2),
    Reported_Cases INT
);
CREATE TABLE patient_data (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_of_Birth DATE,
    Phone_Number VARCHAR(15),
    Next_of_Kin VARCHAR(100),
    Location_ID INT,
    Date_Added DATE,
    Update_Date DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);
CREATE TABLE health_facility (
    Facility_ID INT PRIMARY KEY,
    Facility_Name VARCHAR(100),
    Location_ID INT,
    Capacity INT,
    Contact_Details VARCHAR(100),
    Date_Added DATE,
    Date_Updated DATE,
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);
CREATE TABLE UserRoles (
    Role_ID INT PRIMARY KEY,
    RoleName VARCHAR(100),
    RoleDescription TEXT,
    AccessLevel VARCHAR(100)
);
CREATE TABLE usermgt (
    User_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Role_ID INT,
    User_name VARCHAR(50),
    Password VARCHAR(100),
    Date_Added DATE,
    FOREIGN KEY (Role_ID) REFERENCES UserRoles(Role_ID)
);
CREATE TABLE system_log (
    Log_ID INT PRIMARY KEY,
    User_ID INT,
    Activity TEXT,
    Timestamp DATETIME,
    IP_Address VARCHAR(15),
    FOREIGN KEY (User_ID) REFERENCES usermgt(User_ID)
);
CREATE TABLE visit_record (
    Visit_ID INT PRIMARY KEY,
    Patient_ID INT,
    Facility_ID INT,
    Visit_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);
CREATE TABLE TreatmentRecords (
    Treatment_ID INT PRIMARY KEY,
    Treatment_Name VARCHAR(50),
    Description TEXT,
    Dosage VARCHAR(50),
    Side_Effects TEXT,
    Visit_ID INT,
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID)
);
CREATE TABLE LabTests (
    Test_ID INT PRIMARY KEY,
    Test_Type VARCHAR(50),
    Test_Result VARCHAR(50),
    Technician_ID INT,
    Visit_ID INT,
    FOREIGN KEY (Visit_ID) REFERENCES visit_record(Visit_ID)
);
CREATE TABLE treatment_outcome (
    Outcome_ID INT PRIMARY KEY,
    Outcome_Name VARCHAR(50),
    Outcome_Description TEXT,
    Date_Added DATE,
    Update_Date DATE
);
CREATE TABLE malaria_cases (
    Case_ID INT PRIMARY KEY,
    Patient_ID INT,
    Facility_ID INT,
    Date_of_Diagnosis DATE,
    Type_of_Malaria VARCHAR(50),
    Treatment_ID INT,
    Outcome_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES TreatmentRecords(Treatment_ID),
    FOREIGN KEY (Outcome_ID) REFERENCES treatment_outcome(Outcome_ID)
);
CREATE TABLE epidemiological_data (
    Data_ID INT PRIMARY KEY,
    Location_ID INT,
    Recorded_Date DATE,
    Cases_Per_Thousand_People INT,
    ITN_Coverage DECIMAL(5,2),
    FOREIGN KEY (Location_ID) REFERENCES geographical_location(Location_ID)
);
CREATE TABLE resource (
    Resource_ID INT PRIMARY KEY,
    Resource_Name VARCHAR(100),
    Resource_Type VARCHAR(50),
    Quantity INT,
    Date_Added DATE,
    Update_Date DATE
);
CREATE TABLE ResourceMgt (
    Resource_ID INT PRIMARY KEY,
    Facility_ID INT,
    Resource_Type VARCHAR(50),
    Quantity INT,
    Date_Added DATE,
    Update_Date DATE,
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID)
);
CREATE TABLE supply_chain (
    Supply_ID INT PRIMARY KEY,
    Facility_ID INT,
    Resource_ID INT,
    Shipment_Date DATE,
    Expected_Arrival_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Facility_ID) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Resource_ID) REFERENCES resource(Resource_ID)
);
CREATE TABLE facility_type (
    Facility_Type_ID INT PRIMARY KEY,
    Type_Name VARCHAR(50),
    Description TEXT,
    Date_Added DATE,
    Date_Updated DATE
);
CREATE TABLE FacilityOperations (
    OperationID INT PRIMARY KEY,
    OperationType VARCHAR(255),
    Date DATE
);
CREATE TABLE referral (
    Referral_ID INT PRIMARY KEY,
    Referred_From INT,
    Referred_To INT,
    Patient_ID INT,
    Referral_Date DATE,
    Reason TEXT,
    FOREIGN KEY (Referred_From) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Referred_To) REFERENCES health_facility(Facility_ID),
    FOREIGN KEY (Patient_ID) REFERENCES patient_data(Patient_ID)
);


















