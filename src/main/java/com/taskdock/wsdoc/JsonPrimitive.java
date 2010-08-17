/*
 * Copyright (c) Taskdock, Inc. 2009-2010. All Rights Reserved.
 */

package com.taskdock.wsdoc;

import org.joda.time.DateTime;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class JsonPrimitive implements JsonType, Serializable {

    private String typeName;
    private List<String> restrictions;

    public JsonPrimitive(String typeName) {
        if (String.class.getName().equals(typeName)) {
            typeName = "string";
        } else if (Boolean.class.getName().equals(typeName)) {
            typeName = "boolean";
        } else if (Byte.class.getName().equals(typeName)) {
            typeName = "byte";
        } else if (Character.class.getName().equals(typeName)) {
            typeName = "char";
        } else if (Double.class.getName().equals(typeName)) {
            typeName = "double";
        } else if (Float.class.getName().equals(typeName)) {
            typeName = "float";
        } else if (Integer.class.getName().equals(typeName)) {
            typeName = "int";
        } else if (Long.class.getName().equals(typeName)) {
            typeName = "long";
        } else if (Short.class.getName().equals(typeName)) {
            typeName = "short";
        } else if (Date.class.getName().equals(typeName)) {
            typeName = "timestamp";
        } else if (DateTime.class.getName().equals(typeName)) {
            typeName = "iso-8610 timestamp string";
        }
        this.typeName = typeName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setRestrictions(List<String> restrictions) {
        this.restrictions = restrictions;
    }

    public List<String> getRestrictions() {
        return restrictions;
    }
}
