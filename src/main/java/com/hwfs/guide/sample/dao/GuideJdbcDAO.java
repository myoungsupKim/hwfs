package com.hwfs.guide.sample.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.sc.cmn.defaults.DefaultYfncDAO;

 /**
 * 외부 DB에 접속하여 처리하는 DAO
 * - 해당 데이터소스에 연결된 DefaultDAO를 상속받아 처리
 * @ClassName GuideJdbcDAO.java
 * @Description GuideJdbcDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 9.01.   kksoo       최초생성
 * </pre>
 * @author FC종합전산구축 : AA kksoo
 * @since 2015. 1. 22.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/guide/sample/guideJdbcDAO")
public class GuideJdbcDAO extends DefaultYfncDAO {

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

}
