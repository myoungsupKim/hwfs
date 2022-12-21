package com.hwfs.sm.srm.dao;

import hone.core.util.record.RecordSet;

import java.sql.Types;
import java.util.Map;

import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

 /**
 * SAP 전표 업로드하는 SapSlipUpload DAO
 * 
 * @ClassName SapSlipUploadDAO.java
 * @Description SapSlipUploadDAO Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.16   	JUN        최초생성
 * </pre>
 * @author FC종합전산구축 : 통합영업 JUN
 * @since 2015.06.16
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sm/srm/sapSlipUploadDAO")
public class SapSlipUploadDAO extends DefaultDAO {
	
	/**
	 * SAP 전표 업로드 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	//100% 세금계산서 발행 매출전표(6B:식재영업,6C:식재도매,6E:연구소,6G:물류매출,6H:기타매출)
	public RecordSet selectSlipListTax100(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipListTax100", mapParam);
	}
	
	//급식, 외식 매출전표(6A:FS사업,6D:외식사업,6A:장례식장,6F:특판,6A:매점POS,6D:외식POS)
	public RecordSet selectSlipListTaxEtc(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipListTaxEtc", mapParam);
	}

	//7A:입금처리
	public RecordSet selectSlipList7A(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7A", mapParam);
	}

	//7B:채권 이관
	public RecordSet selectSlipList7B(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7B", mapParam);
	}

	//7C:선수금발생 관리
	public RecordSet selectSlipList7C(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7C", mapParam);
	}

	//7D:대손처리
	public RecordSet selectSlipList7D(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7D", mapParam);
	}
	
	//7E:선수금 이관
	public RecordSet selectSlipList7E(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7E", mapParam);
	}

	//7F:영업현금 가수금 대체
	public RecordSet selectSlipList7F(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7F", mapParam);
	}

	//7G:채권채무
	public RecordSet selectSlipList7G(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7G", mapParam);
	}
	
	//7H:기타 가수금 대체
	public RecordSet selectSlipList7H(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7H", mapParam);
	}

	//7I:쿠폰(식권)판매/교환/소멸
	public RecordSet selectSlipList7I(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7I", mapParam);
	}

	//7J:상품권 청구
	public RecordSet selectSlipList7J(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList7J", mapParam);
	}

	//8A:영업환불(영업미지급)
	public RecordSet selectSlipList8A(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList8A", mapParam);
	}

	//8B:원가 이관(직원식대처리)
	public RecordSet selectSlipList8B(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList8B", mapParam);
	}

	//8C:Helper
	public RecordSet selectSlipList8C(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList8C", mapParam);
	}

	//8D:영업기타
	public RecordSet selectSlipList8D(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList8D", mapParam);
	}

	//8O:내부이용가계정(내부매출)
	public RecordSet selectSlipList8O(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList8O", mapParam);
	}
	
	//1I:영업기타(H&R) 수입장려금 전표 처리 유형 추가  요청자:유태석  20161223
	public RecordSet selectSlipList1I(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSlipList1I", mapParam);
	}	
	
	/**
	 * 선수금 대체번호 채번
	 * @param mapParam
	 * @return
	 */
	public String getMaxSlipNum(Map<String, Object> mapParam) throws Exception {
		return (String) super.queryForObject("sm.srm.sapSlipUploadDAO.getMaxSlipNum", mapParam, null);
	}
	
	/**
	 * 전표 마스터 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSapSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.insertSapSlipMst", mapParam);
	}
	
	/**
	 * 전표 디테일 저장
	 *
	 * @param mapParam
	 * @return
	 */
	public int insertSapSlipDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.insertSapSlipDtl", mapParam);
	}
	
	/**
	 * 전표 생성시 분개번호 UPDATE 
	 * 
	 * @param mapParam
	 * @return
	 */
	//매출 전체 - 업장 발생 매출 상세 정보 SLA_IF_UPJANG_SALS_DETAIL
	public int updateSlipNumOfSalsDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfSalsDtl", mapParam);
	}

	//매출 : 식재영업, 연구소 - 세금계산서 발생 대상 정보 SLA_TAX_SHET_OCCUR_OBJ
	public int updateSlipNumOfTaxObj(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfTaxObj", mapParam);
	}
	
	//매출 : 외식영업, 단체급식 - 업장 발생 Payment정보 SLA_IF_UPJANG_PAYMENT
	public int updateSlipNumOfPayment(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfPayment", mapParam);
	}

	//7A 입금 : 입금정보 디테일 SLA_AR_RECEIVE_DETAIL
	public int updateSlipNumOfReceiveDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfReceiveDtl", mapParam);
	}

	//7B:채권 이관 : 입금정보 디테일 SLA_AR_RECEIVE_DETAIL ('B07','B16') -- 채권거래처이관, 채권타부서이관
	public int updateSlipNumOfReceiveDtl7B(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfReceiveDtl7B", mapParam);
	}
	
	//7C:선수금발생 관리 : 가수금 대체 정보 SLA_SAP_SUSPENSE_ALT_DETAIL
	public int updateSlipNumOfSusAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfSusAltDtl", mapParam);
	}
	
	//7E:선수금 이관 : 선수금 대체내역에 대한 상세 정보 SLA_ADVANCE_ALT_DETAIL
	public int updateSlipNumOfAdvanceAltDtl7E(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfAdvanceAltDtl7E", mapParam);
	}
	
	//7F:영업현금 가수금 대체 : 영업 현금 대체 정보 SLA_SALES_CASH_ALT_DETAIL
	public int updateSlipNumOfCashAltDtl(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfCashAltDtl", mapParam);
	}
	
	//7F:영업현금 가수금 대체 : 영업 현금 발생 정보 SLA_SALES_CASH_OCCUR_INFO
	public int updateSlipNumOfCashOccurInfo(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfCashOccurInfo", mapParam);
	}
	
	//7H:기타 가수금 대체 : 차변 : 가수금 대체 정보(이자수익) SLA_SAP_SUSPENSE_ALT_DETAIL
	public int updateSlipNumOfSusAltDtlL01(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfSusAltDtlL01", mapParam);
	}
	
	//7H:기타 가수금 대체 : 가수금 대체 정보(잡이익) SLA_SAP_SUSPENSE_ALT_DETAIL
	public int updateSlipNumOfSusAltDtlL02(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfSusAltDtlL02", mapParam);
	}

	//7H:기타 가수금 대체 : 선수금 대체 정보(잡이익) SLA_ADVANCE_ALT_DETAIL
	public int updateSlipNumOfAdvanceAltDtlG01(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfAdvanceAltDtlG01", mapParam);
	}
	
	//7I:쿠폰(식권)판매/교환/소멸 : 채권 마스터 (A06:쿠폰외상판매) SLA_AR_MST
	public int updateSlipNumOfArMstA06(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfArMstA06", mapParam);
	}
	
	//7I:쿠폰(식권)판매/교환/소멸 : 선수금 마스터 (F04:쿠폰판매) SLA_ADVANCE_MST
	public int updateSlipNumOfAdvanceMstF04(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfAdvanceMstF04", mapParam);
	}
	
	//7J:상품권 청구 : 채권 마스터 (A05:상품권 청구) SLA_AR_MST
	public int updateSlipNumOfArMstA05(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfArMstA05", mapParam);
	}
	
	//7J:상품권 청구 : 채권 마스터 (A04:상품권 접수) SLA_AR_MST
	public int updateSlipNumOfArMstA04(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfArMstA04", mapParam);
	}
	
	//8A:영업환불(영업미지급) : 선수금 대체 정보(환불) SLA_ADVANCE_ALT_DETAIL
	public int updateSlipNumOfAdvanceAltDtlH01(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfAdvanceAltDtlH01", mapParam);
	}
	
	//8C:Helper : 업장간 지원정보 RSS_HELPER_SUP_INFO
	public int updateSlipNumOfHelper(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSlipNumOfHelper", mapParam);
	}
	
	/**
	 * 전표 생성시 분개번호 UPDATE procedure 호출
	 *
	 * @param mapParam
	 * @return
	 */
	public Map<String, Object> callProcedure(Map<String, Object> inParam, String callProcName) throws Exception {
		//전달 순서대로 설정
		SqlParameter[] sqlParameter = new SqlParameter[] {
		    new SqlParameter("P_SLIP_NUM",		Types.VARCHAR),
		    new SqlParameter("P_SLIP_STATUS",	Types.VARCHAR),
            new SqlOutParameter("O_RTN",    	Types.VARCHAR),
            new SqlOutParameter("O_RTNMSG", 	Types.VARCHAR)
		};

		// procedure 호출
		return callProcedure(callProcName, sqlParameter, inParam);
	}	
	
	//전표생성취소
	public int updateSapSlipMst(Map<String, Object> mapParam) throws Exception {
		return super.update("sm.srm.sapSlipUploadDAO.updateSapSlipMst", mapParam);
	}

	/**
	 * SAP 월마감 여부를 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectSapClose(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sm.srm.sapSlipUploadDAO.selectSapClose", mapParam);
	}
}
