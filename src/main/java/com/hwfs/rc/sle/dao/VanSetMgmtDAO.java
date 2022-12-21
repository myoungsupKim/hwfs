package com.hwfs.rc.sle.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * VanSetMgmtDAO에 대한 설명 작성
 * @ClassName VanSetMgmtDAO.java
 * @Description VanSetMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 2.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 2.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/vanSetMgmtDAO")
public class VanSetMgmtDAO extends DefaultDAO {
	 
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
			return super.queryForRecordSet("rc.sle.vanSetMgmtDAO.selectList", parameter);
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
			return super.update("rc.sle.vanSetMgmtDAO.insertData", parameter);
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
			return super.update("rc.sle.vanSetMgmtDAO.updateData", parameter);
		}
		/**
		 * maxCodeCreate 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public Record maxCodeCreate(Map<String, Object> parameter) {
			return super.queryForRecord("rc.sle.vanSetMgmtDAO.maxCodeCreate",parameter);
		}
}
