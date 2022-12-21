package com.hwfs.sc.cmn.dao;

import hone.core.util.record.RecordSet;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 구매시스템 첨부파일 검색에 대한 설명 작성
 * @ClassName EproAttachFileSearchDAO.java
 * @Description EproAttachFileSearchDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2017. 2. 17.   kihoon      최초생성
 * </pre>
 * @author FC종합전산구축 : COM kihoon
 * @since 2017. 2. 17.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/eproAttachFileDAO")
public class EproAttachFileDAO extends DefaultDAO {
	
	/**
	 * 
	 * <pre>
	 * 구매시스템 상의 첨부파일 정보를 조회한다(협력사 포탈 업로드)
	 * </pre>
	 *
	 * @return
	 */
	public RecordSet selectFileList_doc(Map <String, Object> mapParam) {
		return queryForRecordSet("sc.cmn.eproAttachFileDAO.selectFileList_doc", mapParam);
	}
}
