<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" encoding="UTF-8" indent="yes"/>

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
      "patients": [
        <xsl:for-each select="Patients/Patient">
          <xsl:sort select="FullName"/>
          {
            "id": "<xsl:value-of select="@patientID"/>",
            "name": "<xsl:value-of select="FullName"/>",
            "gender": "<xsl:value-of select="Gender"/>",
            "dob": "<xsl:value-of select="DOB"/>",
            <xsl:if test="InsuranceID">
              "insuranceID": "<xsl:value-of select="InsuranceID"/>"
            </xsl:if>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ],
      "doctors": [
        <xsl:for-each select="Doctors/Doctor">
          {
            "id": "<xsl:value-of select="@doctorID"/>",
            "name": "<xsl:value-of select="concat(FirstName, ' ', LastName)"/>",
            "specialization": "<xsl:value-of select="Specialization"/>",
            <xsl:choose>
              <xsl:when test="@active='true'">"status": "Active"</xsl:when>
              <xsl:otherwise>"status": "Inactive"</xsl:otherwise>
            </xsl:choose>
          }<xsl:if test="position() != last()">,</xsl:if>
        </xsl:for-each>
      ]
    }
  </xsl:template>

</xsl:stylesheet>
