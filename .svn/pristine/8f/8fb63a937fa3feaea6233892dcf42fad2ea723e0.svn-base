package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 개인정보보호 항목에 대한 암복호 처리 및 마스킹 처리 샘플 DAO
 * 
 * @ClassName GuideEncDAO.java
 * @Description GuideEncDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.02.12.   kksoo        최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/guideEncDAO")
public class GuideEncDAO extends DefaultDAO {
	
	/**
	 * 개인정보보호 항목을 개인정보처리등급에 따라 마스크하여 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectMaskList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideEncDAO.selectMask", parameter);
	}

	/**
	 * 개인정보보호 항목을 개인정보처리등급과 권한에 마스크하여 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectMaskAuthList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideEncDAO.selectMaskAuth", parameter);
	}

	/**
	 * 비밀번호를 제외한 개인정보보호 항목을 입력을 위한 경우에는 복호화하여 조회한다.
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideEncDAO.select", parameter);
	}
	
	public RecordSet selectMgmtMask(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideEncDAO.selectMgmtMask", parameter);
	}

	/**
	 * 개인정보보호 항목을를 추가한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideEncDAO.insert", parameter);
	}
	
	/**
	 * 개인정보보호 항목을 수정한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideEncDAO.update", parameter);
	}
	
	/**
	 * 개인정보보호 항목을 삭제한다.
	 *
	 * @param parameter
	 * @return
	 */
	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideEncDAO.delete", parameter);
	}
	
}
