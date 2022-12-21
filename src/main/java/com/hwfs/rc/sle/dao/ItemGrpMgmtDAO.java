package com.hwfs.rc.sle.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * ItemGrpMgmtDAO에 대한 설명 작성
 * @ClassName ItemGrpMgmtDAO.java
 * @Description ItemGrpMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 3. 13.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 : 외식영업(POS영업관리)
 * @since 2015. 3. 13.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/itemGrpMgmtDAO")
public class ItemGrpMgmtDAO extends DefaultDAO {
	/**
	 * selectList 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemGrpMgmtDAO.selectList", parameter);
	}
	public RecordSet searchList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemGrpMgmtDAO.searchList", parameter);
	}
	
	public RecordSet selectListCheck(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.itemGrpMgmtDAO.selectListCheck", parameter);
	}
	
	/**
	 * insertData 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter : 쿼리문으로 전달되는 Parameter
	 * @return
	 */
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemGrpMgmtDAO.insertData", parameter);
	}
	
	/**
	 * updateData  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public int updateData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.itemGrpMgmtDAO.updateData", parameter);
	}
	
	/**
	 * maxCodeCreate  수정한다.
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @return
	 */
	public Record maxCodeCreate(Map<String, Object> parameter) {
		return super.queryForRecord("rc.sle.itemGrpMgmtDAO.maxCodeCreate",parameter);
	}
	
	public Record selectRecordCnt(Map<String, Object> parameter) {
		return super.queryForRecord("rc.sle.itemGrpMgmtDAO.selectRecordCnt",parameter);
	}
	
}
