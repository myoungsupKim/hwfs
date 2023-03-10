package com.hwfs.sc.cmn.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.cmn.exception.BizException;
import com.hwfs.sc.cmn.dao.IntroFrameDAO;
import com.hwfs.fm.fmo.dao.OrderRequestDAO;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.util.DateUtil;
import com.sun.org.apache.xml.internal.security.utils.Base64;


/**
 * 인트로 화면의 내용을 조회하는 IntroFrame Service Implementation
 *
 * @ClassName IntroFrameServiceImpl.java
 * @Description IntroFrameServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.20    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.05.20
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
 /**
 * IntroFrameServiceImpl에 대한 설명 작성
 * @ClassName IntroFrameServiceImpl.java
 * @Description IntroFrameServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 7. 10.   Administrator        최초생성
 * </pre>
 * @author FC종합전산구축 : 팀명 Administrator
 * @since 2015. 7. 10.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/introFrameService")
public class IntroFrameServiceImpl extends DefaultServiceImpl implements
		IntroFrameService {

	/** LogService */
	// private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** IntroFrameDAO Bean 생성 */
	@Resource(name = "/sc/cmn/introFrameDAO")
	private IntroFrameDAO introFrameDAO;

	/** OrderRequestDAO Bean 생성 */
	@Resource(name = "/fm/fmo/orderRequestDAO")
	private OrderRequestDAO orderRequestDAO;
	
	
	/**
	 * 인트로 화면 목록을 조회한다.
	 *
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 *
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 조회결과
	 * @throws Exception
	 */
	public Map<String, RecordSet> selectList(Map<String, Object> mapParam)
			throws Exception {

		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();
		
		String mainType = "";
		
		//기본화면
		if ("IntroFrameType01".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_01";
			
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("totalBbsList", selectBbs("27", mapParam));
			rtn.put("poBbsList", selectBbs("206", mapParam));
			rtn.put("limsBbsList", selectBbs("50", mapParam));
		}
		else if ("IntroFrameType02".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_02";

			if ("ALL".equals(mapParam.get("viewData").toString())) {
				rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
				rtn.put("totalBbsList", selectBbs("27", mapParam));
				rtn.put("poBbsList", selectBbs("206", mapParam));
//				rtn.put("item01", selectDutyMstList("300001")); //경인 기획식재리스트
//				rtn.put("item02", selectDutyMstList("300002")); //남부(영남) 기획식재리스트
//				rtn.put("item03", selectDutyMstList("300004")); //호남 기획식재리스트
//				rtn.put("item04", selectDutyMstList("300005")); //송탄 기획식재리스트
				rtn.put("chargeList", introFrameDAO.selectChargeUpjangList(mapParam)); //점장별 업장
//				rtn.put("upjangRateList", introFrameDAO.selectUpjangByDutyRateList(mapParam)); //업장별 기획식재 실적
				//rtn.put("unApprovedJumCnt", introFrameDAO.selectUnApprovedJumCnt(mapParam)); //인트로 미승인(점장)
				rtn.put("unApprovalJumJang", introFrameDAO.selectUnApprovedJumJang(mapParam));
				rtn.put("checkList01", introFrameDAO.selectCheckList01(mapParam));
				rtn.put("checkList02", introFrameDAO.selectCheckList02(mapParam));
				mapParam.put("dt", DateUtil.addDay(2, "yyyyMMdd"));
				rtn.put("checkList03", introFrameDAO.selectCheckList03(mapParam));
				rtn.put("doBondCount", introFrameDAO.selectDoBondCount(mapParam));
				rtn.put("myDesk04", introFrameDAO.selectMyDesk04(mapParam));
				rtn.put("myDesk03", introFrameDAO.selectMyDesk03(mapParam));
				rtn.put("limsBbsList", selectBbs("50", mapParam));
				rtn.put("pbBbsList", selectBbs("44", mapParam));
			}
//			else if ("300001".equals(mapParam.get("viewData").toString())) {
//				rtn.put("item01", selectDutyMstList("300001")); //경인 기획식재리스트
//			}
//			else if ("300002".equals(mapParam.get("viewData").toString())) {
//				rtn.put("item02", selectDutyMstList("300002")); //남부(영남) 기획식재리스트
//			}
//			else if ("300004".equals(mapParam.get("viewData").toString())) {
//				rtn.put("item03", selectDutyMstList("300004")); //호남 기획식재리스트
//			}
//			else if ("300005".equals(mapParam.get("viewData").toString())) {
//				rtn.put("item04", selectDutyMstList("300005")); //호남 기획식재리스트
//			}
		}
		//식재급식
		else if ("IntroFrameType03".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_03";
			rtn.put("personalList", introFrameDAO.selectPersonal01List(mapParam));
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("speedBbsList", selectBbs("185", mapParam));
			rtn.put("totalBbsList", selectBbs("21", mapParam));
			rtn.put("goodsBbsList", selectBbs("81", mapParam));
			rtn.put("fileBbsList", selectBbs("25", mapParam));
			
			Record r = introFrameDAO.selectUseCreditYn(mapParam);

			//===============2015-10-15:csy=============================	
			// 기준일자 SET : 최종발주일자 관련 변수
			mapParam.put("schNeedDate", r.getString("needDate"));
			mapParam.put("schMainUpjang", r.getString("mainUpjang"));
			mapParam.put("schUpjang", r.getString("upjang"));
			
			RecordSet rs;
			String sUpjangList = "";
			
			// 기준일자 SET
			if ("Y".equals(r.getString("headCreditYn"))) {
				rs = orderRequestDAO.selectNeedDate(mapParam);
			}
			else {
				rs = orderRequestDAO.selectNeedDate2(mapParam);
			}
			if (rs.size() > 0)
			{
				Map map = rs.get(0);
				mapParam.put("schNeedDate", map.get("needDate").toString());
			}
			//===============2015-11-02:csy=============================	
			// 업장리스트 구하기
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("schHeadCreditYn", "Y");
				rs = orderRequestDAO.selectCreUpjang(mapParam);
				
				for (int i = 0 ; i < rs.size() ; i++) {
					Map<String, Object> rowData = rs.get(i);
						sUpjangList += ", " + rowData.get("upjang").toString();
				}
				if (sUpjangList.equals(""))
					sUpjangList = "(NULL)";
				else
					sUpjangList = "(" + sUpjangList.substring(1) + ")";
					
				mapParam.put("sUpjangList", sUpjangList);
			}
			
			//===============2015-10-15:csy=============================	
			
			/* 여신정보 조회 분리
			// 여신정보 GET
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("mainUpjang", r.getString("mainUpjang"));
				rtn.put("creditList", introFrameDAO.selectMainUpjangCredit(mapParam));
			}
			else {
				rtn.put("creditList", introFrameDAO.selectUpjangCredit(mapParam));
			}
			*/

		}
		//식재대리점
		else if ("IntroFrameType04".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_04";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("personalList", introFrameDAO.selectPersonal02List(mapParam));
			rtn.put("totalBbsList", selectBbs("183", mapParam));
			rtn.put("speedBbsList", selectBbs("22", mapParam));
			rtn.put("goodsBbsList", selectBbs("184", mapParam));
		}
		//식재CS
		else if ("IntroFrameType05".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_05";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("speedBbsList", selectBbs("185", mapParam));
			rtn.put("totalBbsList", selectBbs("21", mapParam));
			rtn.put("oneBbsList", selectBbs("23", mapParam));
			rtn.put("fileBbsList", selectBbs("25", mapParam));
		}
		else if ("IntroFrameType06".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_06";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("totalBbsList", selectBbs("27", mapParam));

			mapParam.put("pageCnt", super.propertiesService.getInt("intro." + mapParam.get("introFrameId").toString() + ".eFoodistList.count"));
			rtn.put("eFoodistList", introFrameDAO.selectEFoodistList(mapParam));
			rtn.put("salesUpjangList", introFrameDAO.selectSalesUpjangList(mapParam));
		}
		//FS팀장
		else if ("IntroFrameType07".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_07";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("totalBbsList", selectBbs("27", mapParam));
			rtn.put("upjangRateList", introFrameDAO.selectUpjangByDutyRateList(mapParam)); //업장별 기획식재 실적
			rtn.put("clearCheckList", introFrameDAO.selectClearCheckList(mapParam));
			
			/* START 식재료율 초과사업장 속도개선 */
			//식재료율 초과사업장코드를 얻는다(팀장별)
			RecordSet getUpjangList = introFrameDAO.selectGetPlanUpperUpjangList(mapParam);
			
			//추출된 사업장코드를 IN절에 담기위해 strKeyword를 생성한다
			String strKeyword	= "";
			int LastRowCnt = getUpjangList.size() - 1;
			
			for (int i=0; i<getUpjangList.size(); i++) {
	        	strKeyword += "'" + LimsUtil.checkNull(getUpjangList.get(i).get("upjang")) + "'";
	        	if ( i < LastRowCnt) {
	        	        strKeyword += ",";
	            }
	        }
			
			//strKeyword값을 mapParam담는다
			mapParam.put("strKeyword", strKeyword);
			rtn.put("planUpperUpjangList", introFrameDAO.selectPlanUpperUpjangList(mapParam));
			/* END 식재료율 초과사업장 속도개선 */
			
			rtn.put("upjangPlNotInputList", introFrameDAO.selectUpjangPlNotInputList(mapParam));
			//rtn.put("unApprovedTeamCnt", introFrameDAO.selectUnApprovedTeamCnt(mapParam));
			rtn.put("unApprovalTeamJang", introFrameDAO.selectUnApprovedTeamJang(mapParam));
			rtn.put("checkList01", introFrameDAO.selectCheckList01(mapParam));
			rtn.put("checkList02", introFrameDAO.selectCheckList02(mapParam));
			mapParam.put("dt", DateUtil.addDay(2, "yyyyMMdd"));
			rtn.put("checkList03", introFrameDAO.selectCheckList03(mapParam));
			rtn.put("doBondCount", introFrameDAO.selectDoBondCount(mapParam));
			rtn.put("myDesk04", introFrameDAO.selectMyDesk04(mapParam));
		}
		else if ("IntroFrameType08".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_DEF";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			//rtn.put("totalBbsList", selectBbs("27", mapParam));
			//rtn.put("poBbsList", selectBbs("36", mapParam));
			//rtn.put("limsBbsList", selectBbs("50", mapParam));
		}
		//외식점장
		else if ("IntroFrameType09".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_08";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("clearCheckList", introFrameDAO.selectClearCheckList(mapParam));
			rtn.put("poBbsList", selectBbs("206", mapParam));
			rtn.put("limsBbsList", selectBbs("50", mapParam));
			rtn.put("upjangSaleChart", introFrameDAO.selectUpjangSaleChart(mapParam));
			rtn.put("upjangBondList", introFrameDAO.selectUpjangBondList(mapParam));
			rtn.put("weatherList", introFrameDAO.selectWeatherList(mapParam));
		}
		//외식팀장
		else if ("IntroFrameType10".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_09";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("clearCheckList", introFrameDAO.selectClearCheckList(mapParam));
			rtn.put("totalBbsList", selectBbs("27", mapParam));
			//rtn.put("limsBbsList", selectBbs("50", mapParam));
			rtn.put("tmSaleChart", introFrameDAO.selectTmSaleChart(mapParam));
			rtn.put("tmBondList", introFrameDAO.selectTmBondList(mapParam));
			rtn.put("weatherList", introFrameDAO.selectWeatherList(mapParam));
		}
		//식재도매
		else if ("IntroFrameType11".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_11";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("wholeSaleList", introFrameDAO.selectsWholeSaleList(mapParam));
			rtn.put("totalBbsList", selectBbs("27", mapParam));
			rtn.put("bbsList", selectBbs("181", mapParam));
		}
		else if ("IntroFrameType13".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_13";
			rtn.put("personalList", introFrameDAO.selectPersonal02List(mapParam));
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("speedBbsList", selectBbs("185", mapParam));
			rtn.put("totalBbsList", selectBbs("21", mapParam));
			rtn.put("goodsBbsList", selectBbs("81", mapParam));
			rtn.put("fileBbsList", selectBbs("25", mapParam));
			
			Record r = introFrameDAO.selectUseCreditYn(mapParam);

			//===============2015-10-15:csy=============================	
			// 기준일자 SET : 최종발주일자 관련 변수
			mapParam.put("schNeedDate", r.getString("needDate"));
			mapParam.put("schMainUpjang", r.getString("mainUpjang"));
			mapParam.put("schUpjang", r.getString("upjang"));
			
			RecordSet rs;
			String sUpjangList = "";
			
			// 기준일자 SET
			if ("Y".equals(r.getString("headCreditYn"))) {
				rs = orderRequestDAO.selectNeedDate(mapParam);
			}
			else {
				rs = orderRequestDAO.selectNeedDate2(mapParam);
			}
			if (rs.size() > 0)
			{
				Map map = rs.get(0);
				mapParam.put("schNeedDate", map.get("needDate").toString());
			}
			//===============2015-11-02:csy=============================	
			// 업장리스트 구하기
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("schHeadCreditYn", "Y");
				rs = orderRequestDAO.selectCreUpjang(mapParam);
				
				for (int i = 0 ; i < rs.size() ; i++) {
					Map<String, Object> rowData = rs.get(i);
						sUpjangList += ", " + rowData.get("upjang").toString();
				}
				if (sUpjangList.equals(""))
					sUpjangList = "(NULL)";
				else
					sUpjangList = "(" + sUpjangList.substring(1) + ")";
					
				mapParam.put("sUpjangList", sUpjangList);
			}
			
			//===============2015-10-15:csy=============================	
			/*
			// 여신정보 GET
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("mainUpjang", r.getString("mainUpjang"));
				rtn.put("creditList", introFrameDAO.selectMainUpjangCredit(mapParam));
			}
			else {
				rtn.put("creditList", introFrameDAO.selectUpjangCredit(mapParam));
			}
			*/

		}
		//브랜드유통업장
		else if ("IntroFrameType15".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_15";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			
			Record r = introFrameDAO.selectUseCreditYn(mapParam);

			//===============2015-10-15:csy=============================	
			// 기준일자 SET : 최종발주일자 관련 변수
			mapParam.put("schNeedDate", r.getString("needDate"));
			mapParam.put("schMainUpjang", r.getString("mainUpjang"));
			mapParam.put("schUpjang", r.getString("upjang"));

			RecordSet rs;
			String sUpjangList = "";
			
			// 기준일자 SET
			if ("Y".equals(r.getString("headCreditYn"))) {
				rs = orderRequestDAO.selectNeedDate(mapParam);
			}
			else {
				rs = orderRequestDAO.selectNeedDate2(mapParam);
			}
			if (rs.size() > 0)
			{
				Map map = rs.get(0);
				mapParam.put("schNeedDate", map.get("needDate").toString());
			}
			
			//===============2015-11-02:csy=============================	
			// 업장리스트 구하기
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("schHeadCreditYn", "Y");
				rs = orderRequestDAO.selectCreUpjang(mapParam);
				
				for (int i = 0 ; i < rs.size() ; i++) {
					Map<String, Object> rowData = rs.get(i);
						sUpjangList += ", " + rowData.get("upjang").toString();
				}
				if (sUpjangList.equals(""))
					sUpjangList = "(NULL)";
				else
					sUpjangList = "(" + sUpjangList.substring(1) + ")";
					
				mapParam.put("sUpjangList", sUpjangList);
			}
			
			
			//===============2015-10-15:csy=============================	
			// 여신정보 GET
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("mainUpjang", r.getString("mainUpjang"));
				rtn.put("creditList", introFrameDAO.selectMainUpjangCredit(mapParam));
			}
			else {
				rtn.put("creditList", introFrameDAO.selectUpjangCredit(mapParam));
			}
			
			rtn.put("personalList", introFrameDAO.selectPersonal01List(mapParam));
			rtn.put("totalBbsList", selectBbs("241", mapParam));//21->241
			//rtn.put("speedBbsList", selectBbs("179", mapParam));
			rtn.put("goodsBbsList", selectBbs("242", mapParam));//81->242
		}
		//브랜드유통영업사원
		else if ("IntroFrameType16".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_16";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			rtn.put("totalBbsList", selectBbs("241", mapParam));//27->241
			rtn.put("goodsBbsList", selectBbs("242", mapParam));//행사알림추가
			
			
			mapParam.put("pageCnt", super.propertiesService.getInt("intro." + mapParam.get("introFrameId").toString() + ".eFoodistList.count"));
			rtn.put("eFoodistList", introFrameDAO.selectEFoodistList(mapParam));
			rtn.put("salesUpjangList", introFrameDAO.selectSalesUpjangList(mapParam));
		}
		//식재가맹정
		else if ("IntroFrame_spoon".equals(mapParam.get("introFrameId").toString())) {
			mainType = "INTRO_SPON";
			rtn.put("quickList", introFrameDAO.selectQuickList(mapParam));
			
			Record r = introFrameDAO.selectUseCreditYn(mapParam);

			//===============2015-10-15:csy=============================	
			// 기준일자 SET : 최종발주일자 관련 변수
			mapParam.put("schNeedDate", r.getString("needDate"));
			mapParam.put("schMainUpjang", r.getString("mainUpjang"));
			mapParam.put("schUpjang", r.getString("upjang"));

			RecordSet rs;
			String sUpjangList = "";
			
			// 기준일자 SET
			if ("Y".equals(r.getString("headCreditYn"))) {
				rs = orderRequestDAO.selectNeedDate(mapParam);
			}
			else {
				rs = orderRequestDAO.selectNeedDate2(mapParam);
			}
			if (rs.size() > 0)
			{
				Map map = rs.get(0);
				mapParam.put("schNeedDate", map.get("needDate").toString());
			}
			
			//===============2015-11-02:csy=============================	
			// 업장리스트 구하기
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("schHeadCreditYn", "Y");
				rs = orderRequestDAO.selectCreUpjang(mapParam);
				
				for (int i = 0 ; i < rs.size() ; i++) {
					Map<String, Object> rowData = rs.get(i);
						sUpjangList += ", " + rowData.get("upjang").toString();
				}
				if (sUpjangList.equals(""))
					sUpjangList = "(NULL)";
				else
					sUpjangList = "(" + sUpjangList.substring(1) + ")";
					
				mapParam.put("sUpjangList", sUpjangList);
			}
			
			
			//===============2015-10-15:csy=============================	
			// 여신정보 GET
			if ("Y".equals(r.getString("headCreditYn"))) {
				mapParam.put("mainUpjang", r.getString("mainUpjang"));
				rtn.put("creditList", introFrameDAO.selectMainUpjangCredit(mapParam));
			}
			else {
				rtn.put("creditList", introFrameDAO.selectUpjangCredit(mapParam));
			}
			
			rtn.put("personalList", introFrameDAO.selectPersonal01List(mapParam));
			rtn.put("totalBbsList", selectBbs("21", mapParam));
			//rtn.put("speedBbsList", selectBbs("179", mapParam));
			rtn.put("goodsBbsList", selectBbs("81", mapParam));
		}
//		else if ("IntroFrameType06".equals(mapParam.get("introFrameId").toString())) {
//
//		}
//		else if ("IntroFrameType07".equals(mapParam.get("introFrameId").toString())) {
//		}
//		else if ("IntroFrameType08".equals(mapParam.get("introFrameId").toString())) {
//		}
		Map<String, Object> p = new HashMap<String, Object>();
		p.put("mainType", mainType);
		rtn.put("mainImageFileName", introFrameDAO.selectMainImage(p));

		return rtn;
	}
	public Map<String, RecordSet> selectCreditList(Map<String, Object> mapParam) throws Exception {
		
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		
		String uKey = mapParam.get("uKey").toString();
		String verify = mapParam.get("upjang").toString() + sdFormat.format(nowDate);
		String vKey = Base64.encode(verify.getBytes());
		//System.out.println(uKey+"#"+vKey+"##"+vKey.substring(0, vKey.length()-1));
		if ( !uKey.equals(vKey.substring(0, vKey.length()-1)) ) {
			throw new BizException(messageService.getMessage("fail.common.msg"));
		}
		
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();
		
		Record r = introFrameDAO.selectUseCreditYn(mapParam);
		
		// 기준일자 SET : 최종발주일자 관련 변수
		mapParam.put("schNeedDate", r.getString("needDate"));
		mapParam.put("schMainUpjang", r.getString("mainUpjang"));
		mapParam.put("schUpjang", r.getString("upjang"));
		
		RecordSet rs;
		String sUpjangList = "";
		
		// 기준일자 SET
		if ("Y".equals(r.getString("headCreditYn"))) {
			rs = orderRequestDAO.selectNeedDate(mapParam);
		}
		else {
			rs = orderRequestDAO.selectNeedDate2(mapParam);
		}
		if (rs.size() > 0)
		{
			Map map = rs.get(0);
			mapParam.put("schNeedDate", map.get("needDate").toString());
		}
		
		//===============2015-11-02:csy=============================	
		// 업장리스트 구하기
		if ("Y".equals(r.getString("headCreditYn"))) {
			mapParam.put("schHeadCreditYn", "Y");
			rs = orderRequestDAO.selectCreUpjang(mapParam);
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Map<String, Object> rowData = rs.get(i);
					sUpjangList += ", " + rowData.get("upjang").toString();
			}
			if (sUpjangList.equals(""))
				sUpjangList = "(NULL)";
			else
				sUpjangList = "(" + sUpjangList.substring(1) + ")";
				
			mapParam.put("sUpjangList", sUpjangList);
		}
		
		
		// 여신정보 GET
		if ("Y".equals(r.getString("headCreditYn"))) {
			mapParam.put("mainUpjang", r.getString("mainUpjang"));
			rtn.put("creditList", introFrameDAO.selectMainUpjangCredit(mapParam));
		}
		else {
			rtn.put("creditList", introFrameDAO.selectUpjangCredit(mapParam));
		}

		return rtn;
	}
	

	public Map<String, RecordSet> selectBudgetList(Map<String, Object> mapParam) throws Exception {
		
		DateFormat sdFormat = new SimpleDateFormat("yyyyMMdd");
		Date nowDate = new Date();
		
		String uKey = mapParam.get("uKey").toString();
		String verify = mapParam.get("upjang").toString() + sdFormat.format(nowDate);
		String vKey = Base64.encode(verify.getBytes());
		//System.out.println(uKey+"#"+vKey+"##"+vKey.substring(0, vKey.length()-1));
		if ( !uKey.equals(vKey.substring(0, vKey.length()-1)) ) {
			throw new BizException(messageService.getMessage("fail.common.msg"));
		}
		
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();
		rtn.put("budgetList", introFrameDAO.selectUpjangBudget(mapParam));
		
		return rtn;
	}

	public Map<String, RecordSet> selectUpjangToMonthList(Map<String, Object> mapParam) throws Exception {
		Map<String, RecordSet> rtn = new HashMap<String, RecordSet>();

		rtn.put("upjangToMonthList", introFrameDAO.selectUpjangToMothList(mapParam)); //업장별 당월누계
		rtn.put("upjangTwoWeekChart", introFrameDAO.selectUpjangTwoWeekChart(mapParam)); //업장별 당월누계

		return rtn;
	}

	private RecordSet selectDutyMstList(String centerCode) throws Exception {
		Map<String, Object> parameter = new HashMap<String, Object>();
		parameter.put("centerCode", centerCode);
		return introFrameDAO.selectDutyMstList(parameter);
	}

	/**
	 * 게시판 정보를 조회한다.
	 *
	 * @param bbsId
	 * @param parameter
	 * @return
	 * @throws Exception
	 */
	private RecordSet selectBbs(String bbsId, Map<String, Object> parameter) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("bbsId", bbsId);
		param.put("qid", "BbsList1");
		param.put("upjang", parameter.get("upjang"));
		param.put("pageCnt", super.propertiesService.getInt("intro." + parameter.get("introFrameId").toString() + ".bbsList.count"));

		RecordSet rs = null;
		Record rc = introFrameDAO.selectBbsProperty(param);
		String vocYn = rc.getString("vocYn");
		String mainYn = rc.getString("mainYn");
		String privYn = rc.getString("privYn");

		if ("Y".equals(vocYn)) {
			if ("본부".equals(parameter.get("userKind").toString())) {
				param.put("writeSabun", "");
			}
			else {
				param.put("writeSabun", parameter.get("writeSabun"));
			}

		}
		else if ("Y".equals(mainYn)) {
			if ("본부".equals(parameter.get("userKind").toString())) {
				param.put("mainUpjang", "");
			}
			else {
				param.put("mainUpjang", parameter.get("mainUpjang"));
			}
		}

		if ("Y".equals(privYn) && !"내부".equals(parameter.get("userType").toString())) { //Integer.parseInt(parameter.get("authLevel").toString()) < 99) {
			param.put("qid", "BbsList2");
		}

		rs = introFrameDAO.selectBbsList(param);

		return rs;
	}

}
