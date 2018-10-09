<?xml version="1.0" encoding="UTF-8"?>
<!--
  ~ This file is part of ***  M y C o R e  ***
  ~ See http://www.mycore.de/ for details.
  ~
  ~ MyCoRe is free software: you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation, either version 3 of the License, or
  ~ (at your option) any later version.
  ~
  ~ MyCoRe is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~ GNU General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with MyCoRe.  If not, see <http://www.gnu.org/licenses/>.
  -->

<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                xmlns:mods="http://www.loc.gov/mods/v3"
                xmlns:xlink="http://www.w3.org/1999/xlink"
>


  <xsl:template match="mods:genre[@authorityURI='http://www.mycore.org/classifications/mir_genres'][1]" mode="extension">
    <xsl:choose>
      <xsl:when test="count(../mods:genre[@authorityURI='http://www.mycore.org/classifications/mir_genres']) &gt; 1">
        <fn:array key="learningResourceType">
          <xsl:for-each select="mods:genre[@authorityURI='http://www.mycore.org/classifications/mir_genres']">
            <xsl:call-template name="printLearningResource">
              <xsl:with-param name="valueURI" select="@valueURI" />
            </xsl:call-template>
          </xsl:for-each>
        </fn:array>
      </xsl:when>
      <xsl:otherwise>
        <fn:string key="learningResourceType">
          <xsl:call-template name="printLearningResource">
            <xsl:with-param name="valueURI" select="@valueURI" />
          </xsl:call-template>
        </fn:string>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="printLearningResource">
    <xsl:param name="valueURI" />
    <xsl:variable name="trimmed" select="substring-after(normalize-space($valueURI),'#')" />
    <xsl:variable name="genreURI"
                  select="concat('classification:metadata:0:children:mir_genres:',$trimmed)" />
    <xsl:value-of select="document($genreURI)//category/label[@xml:lang='en']/@text" />
  </xsl:template>

</xsl:stylesheet>
