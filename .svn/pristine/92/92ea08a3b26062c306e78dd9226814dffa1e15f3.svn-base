package com.hwfs.sc.cmn.dao;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.hwfs.cmn.defaults.DefaultDAO;

/**
 * 인트로 화면의 내용을 조회하는 IntroFrame DAO
 *
 * @ClassName IntroFrameDAO.java
 * @Description IntroFrameDAO Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20   	김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.20
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Repository("/sc/cmn/introFrameDAO")
public class IntroFrameDAO extends DefaultDAO {

	public Record selectBbsProperty(Map<String, Object> parameter) throws Exception {
		return super.queryForRecord("sc.cmn.introFrameDAO.selectBbsProperty", parameter);
	}

	/**
	 * 인트로 화면 목록을 조회한다.
	 *
	 * @param mapParam
	 * @return
	 */
	public RecordSet selectBbsList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.select" + mapParam.get("qid").toString(), mapParam);
	}

	public RecordSet selectQuickList(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectQuickList",
				mapParam);
	}

	public RecordSet selectPersonal01List(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.cmn.introFrameDAO.selectPersonal01List", mapParam);
	}

	public RecordSet selectPersonal02List(Map<String, Object> mapParam)
			throws Exception {
		return super.queryForRecordSet(
				"sc.cmn.introFrameDAO.selectPersonal02List", mapParam);
	}
	/**
	 * 기획식재리스트
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDutyMstList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectDutyMstList", mapParam);
	}

	/**
	 * 업장별 기획실재 실적 리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangByDutyRateList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangByDutyRateList", mapParam);
	}

	/**
	 * 업장별 당월누계 리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangToMothList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangToMothList", mapParam);
	}

	/**
	 * 업장별 최근 2주 식재료율 차트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangTwoWeekChart(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangTwoWeekChart", mapParam);
	}

	/**
	 * 점장별 업장리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectChargeUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectChargeUpjangList", mapParam);
	}

	/**
	 * 위생점검리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectClearCheckList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectClearCheckList", mapParam);
	}
	
	/**
	 * 팀장별 계획대비 재료비 초과 사업장 목록 추출
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectGetPlanUpperUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectGetPlanUpperUpjangList", mapParam);
	}

	/**
	 * 계획대비 재료비 초과 사업장
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectPlanUpperUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectPlanUpperUpjangList", mapParam);
	}

	/**
	 * 일일손익미확인업장
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUpjangPlNotInputList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangPlNotInputList", mapParam);
	}

	/**
	 * E-Foodist 리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectEFoodistList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectEFoodistList", mapParam);
	}

	/**
	 * 영업사원에 대한 보증보험 만료예정리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectSalesUpjangList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectSalesUpjangList", mapParam);
	}
	
	/**
	 * FS점장 미승인 리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUnApprovedJumJang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUnApprovedJumJang", mapParam);
	}
	
	/**
	 * selectUnApprovedJumCnt 기능 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUnApprovedJumCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUnApprovedJumCnt", mapParam);
	}
	
	
	/**
	 * FS팀장 미승인 리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUnApprovedTeamJang(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUnApprovedTeamJang", mapParam);
	}
	
	
	/**
	 * 인트로 미승인(팀장)
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectUnApprovedTeamCnt(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUnApprovedTeamCnt", mapParam);
	}
	
	public Record selectUseCreditYn(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecord("sc.cmn.introFrameDAO.selectUseCreditYn", mapParam);
	}
	
	public RecordSet selectMainUpjangCredit(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectMainUpjangCredit", mapParam);
	}
	
	public RecordSet selectUpjangCredit(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangCredit", mapParam);
	}
	
	public RecordSet selectUpjangBudget(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangBudget", mapParam);
	}
	
	public RecordSet selectUpjangSaleChart(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangSaleChart", mapParam);
	}
	
	public RecordSet selectUpjangBondList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectUpjangBondList", mapParam);
	}
	
	public RecordSet selectTmSaleChart(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectTmSaleChart", mapParam);
	}
	
	public RecordSet selectTmBondList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectTmBondList", mapParam);
	}
	
	public RecordSet selectsWholeSaleList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectsWholeSaleList", mapParam);
	}
	
	public RecordSet selectWeatherList(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectWeatherList", mapParam);
	}

	/**
	 * FS점장/팀장 : 전일재고체크리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCheckList01(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectCheckList01", mapParam);
	}

	/**
	 * FS점장/팀장 : 급식운영일지체크리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCheckList02(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectCheckList02", mapParam);
	}

	/**
	 * FS점장/팀장 : 자동구매신청체크리스트
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectCheckList03(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectCheckList03", mapParam);
	}
	
	/**
	 * fs점장/팀장 도래채권수(업장별)
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectDoBondCount(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectDoBondCount", mapParam);
	}

	/**
	 * 식단공유
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectMyDesk04(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectMyDesk04", mapParam);
	}
	
	/**
	 * 구매반려
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 */
	public RecordSet selectMyDesk03(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectMyDesk03", mapParam);
	}
	
	public RecordSet selectMainImage(Map<String, Object> mapParam) throws Exception {
		return super.queryForRecordSet("sc.cmn.introFrameDAO.selectMainImage", mapParam);
	}
	
}
