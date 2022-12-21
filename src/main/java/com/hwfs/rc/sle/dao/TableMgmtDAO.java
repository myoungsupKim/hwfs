package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * TableMgmtDAO에 대한 설명 작성
 * @ClassName TableMgmtDAO.java
 * @Description TableMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 3.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 3.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/tableMgmtDAO")
public class TableMgmtDAO extends DefaultDAO {
	
	
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectGrpList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.tableMgmtDAO.selectGrpList", parameter);
	}
	
	/**
	 * selectViewGrpList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectViewGrpList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.tableMgmtDAO.selectViewGrpList", parameter);
	}
	 	
 	 	
	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertGrpData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.tableMgmtDAO.insertGrpData", parameter);
	}
 
	/**
	 * updateData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateGrpData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.tableMgmtDAO.updateGrpData", parameter);
	}
	
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.tableMgmtDAO.selectList", parameter);
	}
	 	
 	 	
	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.tableMgmtDAO.insertData", parameter);
	}
 
	/**
	 * updateData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.tableMgmtDAO.updateData", parameter);
	}


	/**
	 * 그룹코드의 사용상태가 [사용안함] 상태인 경우에는 전체 공통코드를 [사용안함] 상태로 변경한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateUseAllData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.tableMgmtDAO.updateUseAllData", parameter);
	}
}
