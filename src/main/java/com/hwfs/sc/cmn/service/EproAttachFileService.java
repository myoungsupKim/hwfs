package com.hwfs.sc.cmn.service;

import java.util.Map;

import hone.core.util.record.RecordSet;

 /**
 * EproAttachFileSearchService에 대한 설명 작성
 * @ClassName EproAttachFileSearchService.java
 * @Description EproAttachFileSearchService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017. 2. 17.   kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017. 2. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface EproAttachFileService {
	RecordSet selectFileList_doc(Map <String, Object> parameter);	
}