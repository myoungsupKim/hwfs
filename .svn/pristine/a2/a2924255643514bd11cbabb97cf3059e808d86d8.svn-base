/**
 * Copyright 2009 by HANWHA S&C Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of HANWHA S&C Corp. ("Confidential Information").  You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with HANWHA S&C Corp.
 */
package hanwha.neo.modules.agent;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.httpclient.util.EncodingUtil;

/**
 * @author : 박성수
 * 
 */
public class MultipartRequestEntity implements RequestEntity {

    /** The Content-Type for multipart/form-data. */
    private static final String MULTIPART_FORM_CONTENT_TYPE = "multipart/form-data";
    
    /**
     * The pool of ASCII chars to be used for generating a multipart boundary.
     */
    private static byte[] MULTIPART_CHARS = EncodingUtil.getAsciiBytes(
        "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
    
    /**
     * Generates a random multipart boundary string.
     * @return
     */
    private static byte[] generateMultipartBoundary() {
        Random rand = new Random();
        byte[] bytes = new byte[rand.nextInt(11) + 30]; // a random size from 30 to 40
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = MULTIPART_CHARS[rand.nextInt(MULTIPART_CHARS.length)];
        }
        return bytes;
    }
    
    /** The MIME parts as set by the constructor */
    protected Part[] parts;
    
    private byte[] multipartBoundary;
    
    private HttpMethodParams params;
    
    /**
     * Creates a new multipart entity containing the given parts.
     * @param parts The parts to include.
     * @param params The params of the HttpMethod using this entity.
     */
    public MultipartRequestEntity(Part[] parts, HttpMethodParams params) {
        if (parts == null) {
            throw new IllegalArgumentException("parts cannot be null");
        }
        if (params == null) {
            throw new IllegalArgumentException("params cannot be null");
        }
        this.parts = parts;
        this.params = params;
    }

    /**
     * Returns the MIME boundary string that is used to demarcate boundaries of
     * this part. The first call to this method will implicitly create a new
     * boundary string. To create a boundary string first the 
     * HttpMethodParams.MULTIPART_BOUNDARY parameter is considered. Otherwise 
     * a random one is generated.
     * 
     * @return The boundary string of this entity in ASCII encoding.
     */
    protected byte[] getMultipartBoundary() {
        if (multipartBoundary == null) {
            String temp = (String) params.getParameter(HttpMethodParams.MULTIPART_BOUNDARY);
            if (temp != null) {
                multipartBoundary = EncodingUtil.getAsciiBytes(temp);
            } else {
                multipartBoundary = generateMultipartBoundary();
            }
        }
        return multipartBoundary;
    }

    /**
     * Returns <code>true</code> if all parts are repeatable, <code>false</code> otherwise.
     * @see hanwha.commons.httpclient.methods.RequestEntity#isRepeatable()
     */
    public boolean isRepeatable() {
        for (int i = 0; i < parts.length; i++) {
            if (!parts[i].isRepeatable()) {
                return false;
            }
        }
        return true;
    }

    /* (non-Javadoc)
     * @see org.apache.commons.httpclient.methods.RequestEntity#writeRequest(java.io.OutputStream)
     */
    public void writeRequest(OutputStream out) throws IOException {
        Part.sendParts(out, parts, getMultipartBoundary());
    }

    /* (non-Javadoc)
     * @see org.apache.commons.httpclient.methods.RequestEntity#getContentLength()
     */
    public long getContentLength() {
        try {
            return Part.getLengthOfParts(parts, getMultipartBoundary());            
        } catch (Exception e) {
            System.out.println("An exception occurred while getting the length of the parts : " + e.getMessage());
            e.printStackTrace();
            
            return 0;
        }
    }

    /* (non-Javadoc)
     * @see org.apache.commons.httpclient.methods.RequestEntity#getContentType()
     */
    public String getContentType() {
        StringBuffer buffer = new StringBuffer(MULTIPART_FORM_CONTENT_TYPE);
        buffer.append("; boundary=");
        buffer.append(EncodingUtil.getAsciiString(getMultipartBoundary()));
        return buffer.toString();
    }
	
}
