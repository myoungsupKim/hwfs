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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * @author : 박성수
 * 
 */
public class StringFilePartSource implements PartSource {
	
	private String fileName;
	private byte[] byteContents;
	
	public StringFilePartSource(String fileName, String contents, String enc) throws Exception {
		this.fileName = fileName;
		byteContents = contents.getBytes(enc);
	}

	public InputStream createInputStream() throws IOException {
		ByteArrayInputStream bai = new ByteArrayInputStream(byteContents);
		return bai;
	}

	public String getFileName() {
		return fileName;
	}

	public long getLength() {
		return (long)byteContents.length;
	}

	
	

}