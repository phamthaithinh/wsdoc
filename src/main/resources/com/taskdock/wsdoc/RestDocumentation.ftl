<!--
~ Copyright (c) Taskdock, Inc. 2009-2010. All Rights Reserved.
-->

<#-- @ftlvariable name="docs" type="java.util.List<com.taskdock.wsdoc.RestDocumentation>" -->

<html>
    <head>
        <title>REST Endpoint Documentation</title>
        <style type="text/css">
            div.section-title { font-size: 18px; font-weight: bold; }
            div.resource-summary { font-family: monospace; padding-top: 10px; }
            .resource-summary div { padding-left: 15px }

            div.resource { border-top: 1px solid gray; padding-top: 5px; margin-top: 15px; }
            div.resource-header { font-family: monospace; font-size: 18px; font-weight: bold; padding-bottom: 15px; }

            div.url-subs { padding-bottom: 20px; }
            div.url-subs table { width: 400px; border-spacing: 0px; }
            div.url-subs thead td { border-bottom: 1px dashed gray; }
            .url-sub-key { font-family: monospace; }
            .url-sub-expected-type { font-family: monospace; }

            div.request-body { padding-bottom: 20px; }
            div.response-body { padding-bottom: 20px; }

            div.body-title { width: 400px; border-bottom: 1px dashed gray; }

            div.body-contents { font-family: monospace; }
            div.json-field { padding-left: 15px; }
            span.json-field-name { font-weight: bold; }
            div.json-field span.json-primitive-type { color: gray; }
            div.json-primitive-restrictions { color: gray; padding-left: 30px; }
        </style>
    </head>
    <body>

        <div class="section-title">Overview</div>
        <#list docs as doc>
            <#list doc.resources as resource>
                <div class="resource-summary">
                    <span class="resource-summary-path">${resource.path}</span>
                    <div>
                        <#list resource.requestMethodDocs?sort_by("requestMethod") as methodDoc>
                            <a href="#${methodDoc.requestMethod}_${resource.path}">${methodDoc.requestMethod}</a>
                        </#list>
                    </div>
                </div>
            </#list>
        </#list>

        <#list docs as doc>
            <#list doc.resources as resource>
                <#list resource.requestMethodDocs as methodDoc>
                    <a id="${methodDoc.requestMethod}_${resource.path}"/>
                    <div class="resource">
                        <div class="resource-header">
                            <span class="method">${methodDoc.requestMethod}</span>
                            <span class="path">${resource.path}</span>
                        </div>

                        <#assign subs=methodDoc.urlSubstitutions.substitutions>
                        <#if (subs?keys?size > 0)>
                            <div class="url-subs">
                                <table>
                                    <thead>
                                        <tr><td>URL Substitution Key</td><td>Expected Type</td></tr>
                                    </thead>
                                    <#list subs?keys as key>
                                        <tr>
                                            <td class="url-sub-key">${key}</td>
                                            <td class="url-sub-expected-type"><@render_json subs[key]/></td>
                                        </tr>
                                    </#list>
                                </table>
                            </div>
                        </#if>

                        <#if (methodDoc.requestBody??)>
                            <div class="request-body">
                                <div class="body-title">Request Body</div>
                                <div class="body-contents"><@render_json methodDoc.requestBody/></div>
                            </div>
                        </#if>

                        <#if (methodDoc.responseBody??)>
                            <div class="response-body">
                                <div class="body-title">Response Body</div>
                                <div class="body-contents"><@render_json methodDoc.responseBody/></div>
                            </div>
                        </#if>
                    </div>
                </#list>
            </#list>
        </#list>
    </body>
</html>

<#macro render_json json>
    <#if json.class.name == "com.taskdock.wsdoc.JsonPrimitive">
        <@render_json_primitive json/>
    <#elseif json.class.name == "com.taskdock.wsdoc.JsonObject">
        <@render_json_object json/>
    <#elseif json.class.name == "com.taskdock.wsdoc.JsonArray">
        <@render_json_array json/>
    <#elseif json.class.name == "com.taskdock.wsdoc.JsonDict">
        <@render_json_dict json/>
    </#if>
</#macro>

<#macro render_json_array json>
    <#-- @ftlvariable name="json" type="com.taskdock.wsdoc.JsonArray" -->

    <span class="json-array">[
        <@render_json json.elementType />
    ]</span>
</#macro>

<#macro render_json_dict json>
    <#-- @ftlvariable name="json" type="com.taskdock.wsdoc.JsonDict" -->

    <span class="json-dict">[
        <@render_json json.keyType/>
        -&gt;
        <@render_json json.valueType/>
    ]</span>
</#macro>

<#macro render_json_primitive json>
    <#-- @ftlvariable name="json" type="com.taskdock.wsdoc.JsonPrimitive" -->

    <span class="json-primitive-type">${json.typeName}</span>
    <#if json.restrictions??>
        <div class="json-primitive-restrictions">
            one of [ <#list json.restrictions as restricton>
                ${restricton}<#if restricton_has_next>, </#if>
            </#list> ]</div>
    </#if>
</#macro>

<#macro render_json_object json>
    <#-- @ftlvariable name="json" type="com.taskdock.wsdoc.JsonObject" -->

    <span class="json-object">{
    <div class="json-fields">
        <#list json.fields as field>
            <div class="json-field">
                <span class="json-field-name">${field.fieldName}</span>
                <@render_json field.fieldType/>
            </div>
        </#list>
    </div>
    </span>
    }
</#macro>
