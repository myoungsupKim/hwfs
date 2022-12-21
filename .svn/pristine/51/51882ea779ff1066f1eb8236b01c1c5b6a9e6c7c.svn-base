package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.EproAttachFileDAO;;

 /**
 * EproAttachFileSearchServiceImpl에 대한 설명 작성
 * @ClassName EproAttachFileSearchServiceImpl.java
 * @Description EproAttachFileSearchServiceImpl Class 
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
@Service("/sc/cmn/eproAttachFileService")
public class EproAttachFileServiceImpl extends DefaultServiceImpl implements EproAttachFileService {
	@Resource(name="/sc/cmn/eproAttachFileDAO")
	private EproAttachFileDAO eproAttachFile;
	
	/**
	 * EPRO 시스템의 첨부파일 목록을 조회한다.
	 * <pre>
	 * </pre>
	 *
	 * @return
	 */
	@Override
	public RecordSet selectFileList_doc(Map <String, Object> mapParam) {
		return eproAttachFile.selectFileList_doc(mapParam);
	}

}
