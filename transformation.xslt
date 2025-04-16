<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8" indent="no"/>

  <xsl:template match="/HealthcareProvider">
    {
      "providerID": "<xsl:value-of select="@providerID"/>",
      "facilityName": "<xsl:value-of select="FacilityName"/>",
      "location": {
        "address": "<xsl:value-of select="Location/Address"/>",
        "city": "<xsl:value-of select="Location/City"/>",
        "state": "<xsl:value-of select="Location/State"/>",
        "zip": "<xsl:value-of select="Location/Zip"/>"
      },
      "departments": [
        <xsl:for-each select="Departments/Department">
          <xsl:sort select="@deptCode"/>
          {
            "code": "<xsl:value-of select="@deptCode"/>",
            "name": "<xsl:value-of select="Name"/>",
            "floor": <xsl:value-of select="Floor"/>,
            "staff": [
              <xsl:for-each select="Staff/StaffMember">
                {
                  "id": "<xsl:value-of select="@staffID"/>",
                  "name": "<xsl:value-of select="Name"/>",
                  "role": "<xsl:value-of select="Role"/>"
                }<xsl:if test="position() != last()">,</xsl:if>
              </xsl:for-each>
            ]
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ],
      "medicalStaff": {
        "doctors": [
          <xsl:for-each select="Doctors/Doctor">
            <xsl:sort select="LastName"/>
            {
              "id": "<xsl:value-of select="@doctorID"/>",
              "active": <xsl:value-of select="lower-case(@active)"/>,
              "name": "<xsl:value-of select="concat(FirstName, ' ', LastName)"/>",
              "specialization": "<xsl:value-of select="Specialization"/>",
              "shift": "<xsl:value-of select="Shift"/>"
            }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
        ]
      },
      "patients": [
        <xsl:for-each select="Patients/Patient">
          {
            "patientID": "<xsl:value-of select="@patientID"/>",
            "name": "<xsl:value-of select="FullName"/>",
            "dob": "<xsl:value-of select="DOB"/>",
            "contacts": {
              <xsl:for-each select="Contacts/Contact">
                "<xsl:value-of select="@type"/>": {
                  "name": "<xsl:value-of select="Name"/>",
                  "phone": "<xsl:value-of select="Phone"/>"
                }<xsl:if test="position() != last()">,</xsl:if>
              </xsl:for-each>
            },
            "medicalHistory": [
              <xsl:for-each select="MedicalHistory/Condition">
                "<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if>
              </xsl:for-each>
            ]
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ],
      "appointments": [
        <xsl:for-each select="Appointments/Appointment">
          <xsl:sort select="concat(Date, 'T', Time)"/>
          {
            "appointmentID": "<xsl:value-of select="@apptID"/>",
            "datetime": "<xsl:value-of select="concat(Date, 'T', Time)"/>",
            "purpose": "<xsl:value-of select="Purpose"/>",
            "patient": "<xsl:value-of select="PatientID"/>",
            "doctor": "<xsl:value-of select="DoctorID"/>"
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ],
      "treatments": [
        <xsl:for-each select="Treatments/Treatment">
          {
            "treatmentID": "<xsl:value-of select="TreatmentID"/>",
            "status": "<xsl:value-of select="@status"/>",
            "date": "<xsl:value-of select="Date"/>",
            <xsl:choose>
              <xsl:when test="Description">
                "description": "<xsl:value-of select="Description"/>"
              </xsl:when>
              <xsl:otherwise>
                "description": "No description available"
              </xsl:otherwise>
            </xsl:choose>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ],
      "pharmacy": {
        <xsl:if test="Pharmacy/Medication">
        "medications": [
          <xsl:for-each select="Pharmacy/Medication">
            {
              "medID": "<xsl:value-of select="@medID"/>",
              "name": "<xsl:value-of select="MedName"/>",
              "requiresPrescription": <xsl:value-of select="lower-case(@prescriptionRequired)"/>,
              "stock": <xsl:value-of select="Stock"/>
            }<xsl:if test="position() != last()">,</xsl:if>
          </xsl:for-each>
        ]
        </xsl:if>
      },
      "emergencyServices": {
        "contactNumber": "<xsl:value-of select="EmergencyServices/ContactNumber"/>",
        "ambulanceAvailable": <xsl:value-of select="lower-case(EmergencyServices/AmbulanceAvailable)"/>
      }
    }
  </xsl:template>

</xsl:stylesheet>
