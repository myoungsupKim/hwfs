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

import java.io.OutputStream;
import java.io.IOException;

import org.apache.commons.httpclient.util.EncodingUtil;
/**
 * @author : 박성수
 * 
 */
public class StringPart extends PartBase {

    /** Default content encoding of string parameters. */
    public static final String DEFAULT_CONTENT_TYPE = "text/plain";

    /** Default charset of string parameters*/
    public static final String DEFAULT_CHARSET = "US-ASCII";

    /** Default transfer encoding of string parameters*/
    public static final String DEFAULT_TRANSFER_ENCODING = "8bit";

    /** Contents of this StringPart. */
    private byte[] content;
    
    /** The String value of this part. */
    private String value;

    /**
     * Constructor.
     *
     * @param name The name of the part
     * @param value the string to post
     * @param charset the charset to be used to encode the string, if <code>null</code> 
     * the {@link #DEFAULT_CHARSET default} is used
     */
    public StringPart(String name, String value, String charset) {
        
        super(
            name,
            DEFAULT_CONTENT_TYPE,
            charset == null ? DEFAULT_CHARSET : charset,
            DEFAULT_TRANSFER_ENCODING
        );
        if (value == null) {
            throw new IllegalArgumentException("Value may not be null");
        }
        if (value.indexOf(0) != -1) {
            // See RFC 2048, 2.8. "8bit Data"
            throw new IllegalArgumentException("NULs may not be present in string parts");
        }
        this.value = value;
    }

    /**
     * Constructor.
     *
     * @param name The name of the part
     * @param value the string to post
     */
    public StringPart(String name, String value) {
        this(name, value, null);
    }
    
    /**
     * Gets the content in bytes.  Bytes are lazily created to allow the charset to be changed
     * after the part is created.
     * 
     * @return the content in bytes
     */
    private byte[] getContent() {
//    	try {
//			return "한글".getBytes("UTF-8");
//		} catch (UnsupportedEncodingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
        if (content == null) {
            //content = EncodingUtil.getBytes(value, getCharSet());
        	content = EncodingUtil.getBytes(value, getCharSet());
        }
        return content;
    }
    
    /**
     * Writes the data to the given OutputStream.
     * @param out the OutputStream to write to
     * @throws IOException if there is a write error
     */
    protected void sendData(OutputStream out) throws IOException {
        out.write(getContent());
    }
    
    /**
     * Return the length of the data.
     * @return The length of the data.
     * @throws IOException If an IO problem occurs
     * @see hanwha.commons.httpclient.methods.multipart.Part#lengthOfData()
     */
    protected long lengthOfData() throws IOException {
        return getContent().length;
    }
    
    /* (non-Javadoc)
     * @see org.apache.commons.httpclient.methods.multipart.BasePart#setCharSet(java.lang.String)
     */
    public void setCharSet(String charSet) {
        super.setCharSet(charSet);
        this.content = null;
    }

}

