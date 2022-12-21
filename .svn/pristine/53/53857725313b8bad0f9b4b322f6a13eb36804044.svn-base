package com.hwfs.guide.sample.service;

import java.util.List;
import java.util.Map;

import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.guide.sample.dto.GuideSampleDTO;

import hone.core.util.record.RecordSet;
import hone.online.xplatform.map.DataSetMap;

 /**
 * 개인정보보호 항목에 대한 암복호 처리 및 마스킹 처리 샘플 Service Interface
 * 
 * @ClassName GuideEncService.java
 * @Description GuideEncService Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.12.   kksoo        최초 생성
 *  
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
public interface GuideEncService {
	/**
	 * 개인정보보호 항목을 개인정보처리등급에 따라 마스크하여 조회한다.
	 *
	 * @param parameter
	 * @return
	*/
	RecordSet selectMaskList(Map<String, Object> parameter) throws Exception;

	/**
	 * 비밀번호를 제외한 개인정보보호 항목을 입력을 위한 경우에는 복호화하여 조회한다.
	 *
	 * @param parameter
	 * @return
	*/
	RecordSet selectList(Map<String, Object> parameter) throws Exception;

	int saveList(DataSetMap list) throws Exception;
}
