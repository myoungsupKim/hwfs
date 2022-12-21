package com.hwfs.rc.sle.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * EodMgmtDAO에 대한 설명 작성
 * @ClassName EodMgmtDAO.java
 * @Description EodMgmtDAO Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 6. 15.   박대영        최초생성
 * </pre>
 * @author FC종합전산구축 :외식영업(POS영업관리)
 * @since 2015. 6. 15.
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/rc/sle/eodMgmtDAO")
public class EodMgmtDAO extends DefaultDAO {
	
	//상태검색
	public RecordSet eodList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.eodMgmtDAO.eodList", parameter);
	}
	
	//상태검색
	public RecordSet eodAllList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.eodMgmtDAO.eodAllList", parameter);
	}
	
	//상태검색
	public RecordSet endOfDayList(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.eodMgmtDAO.endOfDayList", parameter);
	}
	
	//마감 업장 리스트
	public RecordSet ListOutlet(Map<String, Object> parameter) {	 
		return super.queryForRecordSet("rc.sle.eodMgmtDAO.ListOutlet", parameter);
	}
	
	//마감결과 저장
	public int insertData(Map<String, Object> parameter) {
		//if (parameter.size() <= 0) return 0;
		return super.update("rc.sle.eodMgmtDAO.insertData", parameter);
	}
	

	//자재정보 전송
	public Map<String, Object> fopostrInfo(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_SALS_SUBINV_PRO", sqlParameter, parameter);
	}
	
	//매출정보 전송
	public Map<String, Object> salesInfo(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_SALS_MST_PRO", sqlParameter, parameter);
	}

	
	//매출상세정보 전송
	public Map<String, Object> salesDetailInfo(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_SALS_DETAIL_PRO", sqlParameter, parameter);
	}
	
	
	//매출결제정보 전송
	public Map<String, Object> salesPaymentInfo(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_PAYMENT_PRO", sqlParameter, parameter);
	}
	
	
	//카드승인정보 전송
	public Map<String, Object> cardApprovalInfo(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_CARD_APPRV_INFO_PRO", sqlParameter, parameter);
	}
	

	
	
	//업장별 매출 집계
	public Map<String, Object> salesSum(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_SALESUM_PRO", sqlParameter, parameter);
	}
	
	//시간별 매출 집계
	public Map<String, Object> timeSum(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_TIMESUM_PRO", sqlParameter, parameter);
	}
	
	//메뉴별 매출 집계
	public Map<String, Object> menuSum(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_MENUSUM_PRO", sqlParameter, parameter);
	}
	
	//할인별 매출 집계
	public Map<String, Object> discnSum(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_DISCNSUM_PRO", sqlParameter, parameter);
	}
	
	
	//외부업장 전송 받은 파일에 대한 마감 집계 처리

	//업장별 매출 집계
	public Map<String, Object> salesSumIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_SALESUM_PRO_IF", sqlParameter, parameter);
	}
	
	//시간별 매출 집계
	public Map<String, Object> timeSumIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_TIMESUM_PRO_IF", sqlParameter, parameter);
	}
	
	//메뉴별 매출 집계
	public Map<String, Object> menuSumIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_MENUSUM_PRO_IF", sqlParameter, parameter);
	}
	

	//매출정보 전송
	public Map<String, Object> salesInfoIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_SALS_MST_PRO_IF", sqlParameter, parameter);
	}

	
	//매출상세정보 전송
	public Map<String, Object> salesDetailInfoIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_SALS_DETAIL_PRO_IF", sqlParameter, parameter);
	}
	
	
	//매출결제정보 전송
	public Map<String, Object> salesPaymentInfoIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_UPJANG_PAYMENT_PRO_IF", sqlParameter, parameter);
	}
	

	
	//카드승인정보 전송
	public Map<String, Object> cardApprovalInfoIf(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_CARD_APPRV_INFO_PRO_IF", sqlParameter, parameter);
	}
	
	//연세대인터페이스
	public Map<String, Object> boInterface(Map<String, Object> parameter) throws Exception { SqlParameter[] sqlParameter = new SqlParameter[] {
			    new SqlParameter("V_DATE", Types.VARCHAR),
			    new SqlParameter("V_MUCD", Types.VARCHAR),
			    new SqlParameter("V_TMCD", Types.VARCHAR),
			    new SqlParameter("V_OUTLET_CD", Types.VARCHAR),
			    new SqlParameter("V_LOGIN_SABUN", Types.VARCHAR),
	            new SqlOutParameter("O_RTN", Types.VARCHAR),
	            new SqlOutParameter("O_RTNMSG", Types.VARCHAR)
			};

		return super.callProcedure("SLE_ERP_BO_INTERFACE", sqlParameter, parameter);
	}
}
