package com.hwfs.rc.sle.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * ReservMgmtDAO에 대한 설명 작성
 * @ClassName ReservMgmtDAO.java
 * @Description ReservMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 4. 29.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 4. 29.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/reservMgmtDAO")
public class ReservMgmtDAO extends DefaultDAO {
	 
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
			return super.queryForRecordSet("rc.sle.reservMgmtDAO.selectList", parameter);
		}
		
		/**
		 * selectListTable 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public RecordSet selectListTable(Map<String, Object> parameter) {	 
			return super.queryForRecordSet("rc.sle.reservMgmtDAO.selectListTable", parameter);
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
			return super.update("rc.sle.reservMgmtDAO.insertData", parameter);
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
			return super.update("rc.sle.reservMgmtDAO.updateData", parameter);
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
			return super.queryForRecord("rc.sle.reservMgmtDAO.maxCodeCreate",parameter);
		}
		
		// 하단 메뉴 입력 하인 처리부분 
		
		/**
		 * selectListGoods 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public RecordSet selectListGoods(Map<String, Object> parameter) {	 
			return super.queryForRecordSet("rc.sle.reservMgmtDAO.selectListGoods", parameter);
		}
		
		/**
		 * insertDataGoods 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public int insertDataGoods(Map<String, Object> parameter) {
			//if (parameter.size() <= 0) return 0;
			return super.update("rc.sle.reservMgmtDAO.insertDataGoods", parameter);
		}
		
		/**
		 * updateDataGoods 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public int updateDataGoods(Map<String, Object> parameter) {
			//if (parameter.size() <= 0) return 0;
			return super.update("rc.sle.reservMgmtDAO.updateDataGoods", parameter);
		}
		
		/**
		 * maxCodeCreateGoods 기능 설명
		 * <pre>
		 * 메소드 상세설명 작성(생략 가능)
		 * </pre>
		 *
		 * @param parameter
		 * @return
		 */
		public Record maxCodeCreateGoods(Map<String, Object> parameter) {
			return super.queryForRecord("rc.sle.reservMgmtDAO.maxCodeCreateGoods",parameter);
		}
}
