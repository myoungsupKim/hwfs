package com.hwfs.guide.sample.dao;

import java.util.HashMap;
import java.util.Map;

import hone.core.util.record.RecordSet;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;
import com.hwfs.guide.sample.dto.GuideSampleDTO;

 /**
 * GuideSampleDAO에 대한 설명 작성
 * @ClassName GuideSampleDAO.java
 * @Description GuideSampleDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 1.22.   김재섭       최초생성
 *  2015.03.24.   kksoo        전자결재 연동 추가
 * </pre>
 * @author FC종합전산구축 : 공통 김재섭
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/guideSampleDAO")
public class GuideSampleDAO extends DefaultDAO {

	/**
	 * GUIDE_SAMPLE의 DATA를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideSampleDAO.selectList", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insert(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.insert", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int update(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.update", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int delete(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.delete", parameter);
	}

	/**
	 * GUIDE_SAMPLE의 DATA를 조회한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectListDTO(GuideSampleDTO parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideSampleDAO.selectList", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertDTO(GuideSampleDTO parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.insertDTO", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateDTO(GuideSampleDTO parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.updateDTO", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteDTO(GuideSampleDTO parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.delete", parameter);
	}















	/**
	 * selectCcsTempList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectCcsTempList(Map<String, Object> parameter) throws Exception {
		return super.queryForRecordSet("guide.sample.guideSampleDAO.selectCcsTempList", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 추가한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertCcsTempList(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.insertCcsTempList", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateCcsTempList(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.updateCcsTempList", parameter);
	}

	/**
	 * GUIDE_SAMPLE에 DATA를 삭제한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int deleteCcsTempList(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.deleteCcsTempList", parameter);
	}

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - Instance ID와 결재진행상태 Update
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateSign(Map<String, Object> parameter) throws Exception {
		return super.update("guide.sample.guideSampleDAO.updateSign", parameter);
	}

	/**
	 * 조직도 샘플
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectOrg() throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		return super.queryForRecordSet("guide.sample.guideSampleDAO.selectOrg", parameter);
	}
}
