<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>
    <xsl:param name="sprint" select="''"/>

    <xsl:template match="/rss/channel">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="2cm"
                                       margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleA4">
                <fo:flow flow-name="xsl-region-body">

                    <fo:block id="type-6" font-size="14pt" font-weight="bold" space-after="5mm" break-before="page">
                        Samenvatting sprint: [<xsl:value-of select="$sprint"/>]
                    </fo:block>

                    <fo:block font-size="14pt" font-weight="bold" space-after="12pt">
                        Done
                    </fo:block>
                    <xsl:call-template name="done-items"/>

                    <fo:block font-size="14pt" font-weight="bold" space-after="12pt">
                        In progress
                    </fo:block>
                    <xsl:call-template name="inprogress-items"/>

                    <fo:block font-size="14pt" font-weight="bold" space-after="12pt">
                        Bugs
                    </fo:block>
                    <xsl:call-template name="bug-items"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template name="done-items">
        <fo:table table-layout="fixed" width="100%" border-collapse="separate">
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="7cm"/>
            <fo:table-column column-width="4cm"/>
            <fo:table-header text-align="left" background-color="silver">
                <fo:table-row>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Issue
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Type
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Summary
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Components
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:if test="count(item[(status/text() = 'Tested')]) = 0">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" padding="1mm" border-width="0.5mm"
                                       border-style="solid">
                            <fo:block>
                                No issues found
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <xsl:for-each select="item">
                    <xsl:if test="(status/text() = 'Tested')">
                        <fo:table-row>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="key/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="type/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="summary/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="component/text()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>

        <fo:block space-after="12pt"></fo:block>

    </xsl:template>

    <xsl:template name="inprogress-items">
        <fo:table table-layout="fixed" width="100%" border-collapse="separate">
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="7cm"/>
            <fo:table-column column-width="4cm"/>
            <fo:table-header text-align="left" background-color="silver">
                <fo:table-row>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Issue
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Type
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Summary
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Components
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:if test="count(item[(status/text() = 'Reviewed') or (status/text() = 'Resolved') or (status/text() = 'In progress')]) = 0">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" padding="1mm" border-width="0.5mm"
                                       border-style="solid">
                            <fo:block>
                                No issues found
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <xsl:for-each select="item">
                    <xsl:if test="(status/text() = 'Reviewed') or (status/text() = 'Resolved') or (status/text() = 'In progress')">
                        <fo:table-row>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="key/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="type/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="summary/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="component/text()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>

        <fo:block space-after="12pt"></fo:block>

    </xsl:template>

    <xsl:template name="bug-items">
        <fo:table table-layout="fixed" width="100%" border-collapse="separate">
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="3cm"/>
            <fo:table-column column-width="7cm"/>
            <fo:table-column column-width="4cm"/>
            <fo:table-header text-align="left" background-color="silver">
                <fo:table-row>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Issue
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Status
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Summary
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                        <fo:block>
                            Components
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>
            <fo:table-body>
                <xsl:if test="count(item[(type/text() = 'Bug')]) = 0">
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3" padding="1mm" border-width="0.5mm"
                                       border-style="solid">
                            <fo:block>
                                No issues found
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <xsl:for-each select="item">
                    <xsl:if test="(type/text() = 'Bug')">
                        <fo:table-row>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="key/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="status/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="summary/text()"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="1mm" border-width="0.5mm" border-style="solid">
                                <fo:block>
                                    <xsl:value-of select="component/text()"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                </xsl:for-each>
            </fo:table-body>
        </fo:table>

        <fo:block space-after="12pt"></fo:block>

    </xsl:template>

</xsl:stylesheet>