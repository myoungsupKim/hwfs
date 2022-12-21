package com.hwfs.fm.fmo.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * 주문신청하는 OrderRequest DAO
 * 
 * @ClassName OrderRequestDAO.java
 * @Description OrderRequestDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.07   	최성연        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 최성연
 * @since 2015.05.07
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/fm/fmo/orderRequestDAO")
public class OrderRequestDAO extends DefaultDAO {

	/**
	 * 구매유형 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectType(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectType", mapParam);

	}
	
	
	/**
	 * 주문신청 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectList", mapParam);
	}
	
	/**
	 * fics주문신청 목록과 hub i/f내역을 대조한다.(fims 기준)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubCompareList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectHubCompareList", mapParam);
	}

	/**
	 * fics주문신청 목록과 hub i/f내역을 대조한다.(허브메카 기준)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHubCompareList2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectHubCompareList2", mapParam);
	}

	
	/**
	 * 주문신청 상세정보 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectDetail", mapParam);
	}

	/**
	 * 주문신청 상세정보의 MAX 진행상태를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectMaxStatus(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectMaxStatus", mapParam);
	}	
	
	/**
	 * 주문신청 창고 목록을 조회한다.(COMBO)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectSubinv", mapParam);
	}
	
	/**
	 * 주문신청 창고 목록을 조회한다. : 1건
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinv2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectSubinv2", mapParam);
	}

	/**
	 * 주문신청 창고 목록을 조회한다.(POPUP)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinvPop(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectSubinvPop", mapParam);
	}
	
	
	
	/**
	 * 주문신청관련 D_DAY 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectDays(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectDays", mapParam);
	}

	/**
	 * 주문신청관련 여신관리여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreYn", mapParam);
	}
	
	/**
	 * 본사통합 여신관리여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectHeadCre(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectHeadCre", mapParam);
	}
	
	/**
	 * 최종 발주일자를 조회한다.[여신체크] ---- 본사통합용(0)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNeedDate(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectNeedDate", mapParam);
	}

	/**
	 * 최종 발주일자를 조회한다.[여신체크] ---- 본사통합용(X)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectNeedDate2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectNeedDate2", mapParam);
	}

	/**
	 * 업장리스트 구하기
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreUpjang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreUpjang", mapParam);
	}
	
	
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreInfo", mapParam);
	}
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다[도매유통_출고관리]
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreInfoFTS(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreInfoFTS", mapParam);
	}
	
	/**
	 * 여신관리여부에 따라 여신정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectCreInfoTest(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreInfoTest", mapParam);
	}

	/**
	 * 선택한 창고에 대한 기본정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSubinvInfo(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectSubinvInfo", mapParam);
	}
	
	
	/**
	 * 구매신청자재검색 화면 조건상단 기본정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopView(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPopView", mapParam);
	}
	
	/**
	 * 구매신청자재검색 정보를 조회한다. : 계약정보 연계된 건만 (구매유형 : 07)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopItem(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPopItem", mapParam);
	}	
	
	/**
	 * 리조트 업장 여부 체크
	 */
	public String selectHnrUpjangYn(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestDAO.selectHnrUpjangYn", mapParam , null);
	}
	

	/**
	 * 구매신청자재검색 정보를 조회한다. : 자재마스터 연계 (구매유형 : 29)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPopItem2(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPopItem2", mapParam);
	}	
	
	
	/**
	 * 주문통제 일자를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOrdCtrlDays(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectOrdCtrlDays", mapParam);
	}	
	
	/**
	 * 업장별 주문통제 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectOrdCtrl(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectOrdCtrl", mapParam);
	}	

	
	/**
	 * 구매신청번호를 GET
	 * @return 구매신청번호
	 * @exception Exception
	 */
	public String selectPrNum(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fmo.orderRequestDAO.selectPrNum", mapParam);

		if (rs == null || rs.size() < 1)
			return "";
		else {
			Map map = rs.get(0);
			return map.get("prNum").toString();
		}
	}
		
	/**
	 * 구매승인번호를 GET
	 * @return 구매승인번호
	 * @exception Exception
	 */
	public String selectApNum(Map<String, Object> mapParam) throws Exception {
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fmo.orderRequestDAO.selectApNum", mapParam);

		if (rs == null || rs.size() < 1)
			return "";
		else {
			Map map = rs.get(0);
			return map.get("apNum").toString();
		}
	}
	
	
	/**
	 * 구매신청정보를 GET
	 * @return 구매신청번호, 구매승인번호
	 * @exception Exception
	 */
	public RecordSet selectPrInfo(Map<String, Object> mapParam) throws Exception {
		return queryForRecordSet("fm.fmo.orderRequestDAO.selectPrInfo", mapParam);
	}	

	/**
	 * 주문신청번호 MASTER 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrMaster(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPrMaster", mapParam);
	}	
	
	/**
	 * 주문신청번호 DETAIL 정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrDetail(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPrDetail", mapParam);
	}	

	/**
	 * 엑셀업로드에 대한  기본정보를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectUpload(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectUpload", mapParam);
	}
	
	/**
	 * 엑셀업로드에 대한  기본정보를 조회한다.
	 *
	 * @param rowData
	 * @return
	 */
	public Map<String, Object> selectUploadRow(Map<String, Object> mapParam) throws Exception {
		return super.queryForList("fm.fmo.orderRequestDAO.selectUpload", mapParam).get(0);
	}
	/**
	 * 엑셀업로드에 대한 여신정보를 CHECK한다
	 * @return 메시지
	 * @exception Exception
	 */
	public String selectCrdCheck2(Map<String, Object> mapParam) throws Exception {
		String amountYn = "";
		String turnYn = "";
		String billDate = "";
		double availAmt = 0;
		double salePrice = 0;
		float lastTurnCnt = 0;
		float turnDaysTot = 0;
		
		RecordSet rs;
		rs = (RecordSet) queryForRecordSet("fm.fmo.orderRequestDAO.selectCreInfo", mapParam);

		if (rs == null || rs.size() < 1)
			return "업장여신정보 확인 불가(관리자 문의)";
		else {
			Map map = rs.get(0);

			amountYn = map.get("creditAmountControlYn").toString(); 
			turnYn = map.get("creditTurnControlYn").toString(); 
			billDate = map.get("lBillDate").toString(); 
			availAmt = Double.parseDouble(map.get("creditAvailAmt").toString()); 
			availAmt = Double.parseDouble(map.get("creditAvailAmt").toString()); 
			
			
			return map.get("apNum").toString();
		}
	}
	
	
	/**
	 * 엑셀업로드에 대한 여신정보를 CHECK한다
	 * @return 메시지
	 * @exception Exception
	 */
	public RecordSet selectCrdCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectCreInfo", mapParam);
	}	

	
	/**
	 * 구매 주문신청관련 수발주제한을 CHECK한다
	 * @return 메시지
	 * @exception Exception
	 */
	public RecordSet selectPoQtyCheck(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPoQtyCheck", mapParam);
	}	
	
	
	
	/**
	 * 주문신청(을)를 등록한다. : 건별 등록용
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.insert", mapParam);
	}
	
	/**
	 * 판매단가 정보에 운영율, 운영단가 정보를 수정한다. : 건별 등록용
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOpPrice(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.updateOpPrice", mapParam);
	}

	/**
	 * 주문신청(을)를 등록한다. : 엑셀업로드용
	 *
	 * @param mapParam
	 * @return
	 */
	public int insert2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.insert2", mapParam);
	}
	
	/**
	 * 판매단가 정보에 운영율, 운영단가 정보를 수정한다. : 엑셀 업로드용
	 *
	 * @param mapParam
	 * @return
	 */
	public int updateOpPrice2(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.updateOpPrice2", mapParam);
	}
	
	
	/**
	 * 주문신청(을)를 수정한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int update(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.update", mapParam);
	}
	
	/**
	 * 주문신청(을)를 삭제한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int delete(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.delete", mapParam);
	}

	/**
	 * 주문신청(을)서를 취소(삭제)한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deletePr(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.deletePr", mapParam);
	}
	
	/**
	 * 허브메카 주문신청(을)서를 취소(삭제)한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int deleteHubPr(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.deleteHubPr", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 임시생성 코드를 삭제 한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public int soprDel(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.soprDel", mapParam);
	}
	
	
	
	
	/**
	 * 주문신청(을)서를 주문번호 생성 규칙에 따라 리스트를 조회한다. (업장,거래처,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrGroup(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPrGroup", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 주문번호 생성 규칙에 따라 PR_NUM을 업데이트한다. (업장,거래처,입고일)
	 *
	 * @param mapParam
	 * @return
	 */
	public int prNumUpdate(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.prNumUpdate", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 주문번호 생성 규칙에 따라 PR_NUM을 업데이트한다. (구매 IF 결과 UPDATE)
	 *
	 * @param mapParam
	 * @return
	 */
	public int prNumUpdateIF(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.prNumUpdateIF", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 주문번호 생성 규칙에 따라 PR_NUM을 업데이트한다. (구매 IF 결과 SELECT)
	 *
	 * @param mapParam
	 * @return
	 */
	public int selectListIF(Map<String, Object> mapParam) throws Exception {
		return super.update("fm.fmo.orderRequestDAO.selectListIF", mapParam);
	}
	
	/**
	 * 주문신청(을)서를 프로시저 호출전 PO_PO 상태값을 다시 확인한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public String lineStatusSelect(Map<String, Object> mapParam) throws Exception {
		return (String)super.queryForObject("fm.fmo.orderRequestDAO.lineStatusSelect", mapParam , null);
	}
	
	/**
	 * 일괄취소 대상 주문정보 조회
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectPrList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("fm.fmo.orderRequestDAO.selectPrList", mapParam);
	}
	
// [속도개선 Project 시작] 2017. 8. 4. 최범주 여신금액 집계 프로시저 추가
	/**
	 *  여신금액 집계 프로시저 호출.
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> procLncrTtz(Map<String, Object> procedureParam) {
		Map<String, Object> rtnProcedure = new HashMap<String, Object>();
		
		//전달 순서대로 설정
        SqlParameter[] sqlParameter = new SqlParameter[] {
              new SqlParameter("p_upjang_cd",        Types.VARCHAR)  // 업장코드
            , new SqlParameter("p_apply_date",       Types.VARCHAR)  // 적용일자          
            , new SqlParameter("p_occur_class",      Types.VARCHAR)  // 발생구분          
            , new SqlParameter("p_occur_amt",        Types.NUMERIC)  // 발생금액          
            , new SqlParameter("p_occur_amt_before", Types.NUMERIC)  // 발생금액(전)  
            , new SqlParameter("p_class_cd",         Types.VARCHAR)  // 구분코드          
            , new SqlParameter("p_occur_table",      Types.VARCHAR)  // 발생테이블       
            , new SqlParameter("p_key_nm",           Types.VARCHAR)  // 키명              
            , new SqlParameter("p_key_value01",      Types.VARCHAR)  // 키1         
            , new SqlParameter("p_key_value02",      Types.VARCHAR)  // 키2         
            , new SqlParameter("p_key_value03",      Types.VARCHAR)  // 키3         
            , new SqlParameter("p_key_value04",      Types.VARCHAR)  // 키4         
            , new SqlParameter("p_key_value05",      Types.VARCHAR)  // 키5         
            , new SqlParameter("p_occur_prg_id",     Types.VARCHAR)  // 프로그램ID   
            , new SqlParameter("p_occur_prg_nm",     Types.VARCHAR)  // 프로그램 한글명
            , new SqlParameter("p_cuser",            Types.VARCHAR)  // 생성자            
            , new SqlOutParameter("o_rtn",           Types.VARCHAR)  // 성공여부          
            , new SqlOutParameter("o_rtnmsg",        Types.VARCHAR)  // 메세지            
        };
        
        // procedure 호출
        String procedureName = "FMS_CREDIT_SUM_PRO";
        try {
        	rtnProcedure = callProcedure(procedureName, sqlParameter, procedureParam);
        } catch(Exception e) {
        	rtnProcedure.put("o_rtn", "N");
        	rtnProcedure.put("o_rtnmsg", "시스템 오류가 발생하였습니다.\n관리자에게 문의하십시오.(통합영업)");
        }
        
		if ( logger.isDebugEnabled() ) {
			logger.debug("\n★★★★★ FCUS.FMS_CREDIT_SUM_PRO(여신금액 집계 프로시저) 인자 ★★★★★");
			logger.debug("p_upjang_cd        : [" + procedureParam.get("p_upjang_cd").toString()        + "]");
			logger.debug("p_apply_date       : [" + procedureParam.get("p_apply_date").toString()       + "]");
			logger.debug("p_occur_class      : [" + procedureParam.get("p_occur_class").toString()      + "]");
			logger.debug("p_occur_amt        : [" + procedureParam.get("p_occur_amt").toString()        + "]");
			logger.debug("p_occur_amt_before : [" + procedureParam.get("p_occur_amt_before").toString() + "]");
			logger.debug("p_class_cd         : [" + procedureParam.get("p_class_cd").toString()         + "]");
			logger.debug("p_occur_table      : [" + procedureParam.get("p_occur_table").toString()      + "]");
			logger.debug("p_key_nm           : [" + procedureParam.get("p_key_nm").toString()           + "]");
			logger.debug("p_key_value01      : [" + procedureParam.get("p_key_value01").toString()      + "]");
			logger.debug("p_key_value02      : [" + procedureParam.get("p_key_value02").toString()      + "]");
			logger.debug("p_key_value03      : [" + procedureParam.get("p_key_value03").toString()      + "]");
			logger.debug("p_key_value04      : [" + procedureParam.get("p_key_value04").toString()      + "]");
			logger.debug("p_key_value05      : [" + procedureParam.get("p_key_value05").toString()      + "]");
			logger.debug("p_occur_prg_id     : [" + procedureParam.get("p_occur_prg_id").toString()     + "]");
			logger.debug("p_occur_prg_nm     : [" + procedureParam.get("p_occur_prg_nm").toString()     + "]");
			logger.debug("p_cuser            : [" + procedureParam.get("p_cuser").toString()            + "]");
			logger.debug("o_rtn              : [" + rtnProcedure.get("o_rtn").toString()                + "]");
			logger.debug("o_rtnmsg           : [" + rtnProcedure.get("o_rtnmsg").toString()             + "]");
		}
        
        return rtnProcedure;
	}
// [속도개선 Project   끝] 2017. 8. 4. 최범주
}
