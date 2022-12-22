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

/**
 * @author : 박성수
 * 
 */
public class NeoUploader extends MultipartUploader {

	public NeoUploader(String host, String port) throws Exception {
		super(host, port);
		addHeader("User-Agent", "ApprovalWordAddIn 1.0");
		//request.UserAgent = "ApprovalWordAddIn 1.0";
		setTarget("/neo/upload.svc?module=approval&cp=temp", true);
	}
	
	public void addParam(String key, String value) {
		super.target += ("&"+key+"="+value);
	}
}
