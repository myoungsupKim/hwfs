package com.hwfs.sc.scz.service;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.sap.EAIRequest;
import com.hwfs.sc.cmn.sap.EAIResponse;
import com.hwfs.sc.cmn.sap.request.FixedAssetsRequest;
import com.hwfs.sc.cmn.sap.service.EAIService;
import com.hwfs.sc.scz.dao.FixedAssetsListDAO;

 /**
 * 고정자산명세서를 조회하는 FixedAssetsList Service Implementation
 * 
 * @ClassName FixedAssetsListServiceImpl.java
 * @Description FixedAssetsListServiceImpl Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.11.11    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.11.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/scz/fixedAssetsListService")
public class FixedAssetsListServiceImpl extends DefaultServiceImpl implements FixedAssetsListService {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	@Resource(name = "/sc/scz/fixedAssetsListDAO")
	private FixedAssetsListDAO fixedAssetsListDAO;
	
	@Resource(name="EAIService")
	EAIService eaiService;
	
	/**
	 * 고정자산명세서 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략하면 삭제할 것
	 * </pre>
	 * 
	 * @param mapParam
	 *            조회조건 Map
	 * @return RecordSet 
	 *            조회결과
	 * @throws Exception
	 */
	public List<Map<String, Object>> selectList(Map<String, Object> mapParam) throws Exception {
		List<Map<String, Object>> resList = new ArrayList<Map<String,Object>>();
		List<EAIRequest> reqList = new ArrayList<EAIRequest>();
		RecordSet cprs = null;
		
		if (mapParam.containsKey("ccCd") && !"".equals(mapParam.get("ccCd").toString())) {
			logger.debug("단건의 자료를 요청한다.");
			
			FixedAssetsRequest fixedAssetsRequest = new FixedAssetsRequest();
			RecordSet rs;
			
			/* 2020.02.18 김명섭 외식사업부 신규 조직 조회 */
			if("2003".equals(mapParam.get("muCd").toString())) {
				rs = fixedAssetsListDAO.selectMapCostCenter(mapParam);
			} else {
				rs = fixedAssetsListDAO.selectSingleCostCenter(mapParam);
			}
			Record r = rs.get(0);
			fixedAssetsRequest.setCcCd(r.getString("ccCd"));
			fixedAssetsRequest.setBaseMonth(mapParam.get("baseMm").toString());
			
			if (mapParam.containsKey("assetsKind") && !"".equals(mapParam.get("assetsKind").toString())) {
				fixedAssetsRequest.setAssetsKind(mapParam.get("assetsKind").toString());
			}
			//recordset카피
			cprs = rs;
			
			reqList.add(fixedAssetsRequest);
		}
		else {
			logger.debug("다건의 자료를 요청한다.");
			
			RecordSet rs;
			/* 2020.02.18 김명섭 외식사업부 신규 조직 조회 */
			/* 2020.03.30 김명섭 본부 전체 조회 기능 추가 */
			if("Y".equals(mapParam.get("chkBonbu").toString())) {
				if("2003".equals(mapParam.get("muCd").toString())) {
					rs = fixedAssetsListDAO.selectBonbuTmCostCenter(mapParam);
				} else {
					rs = fixedAssetsListDAO.selectBonbuCostCenter(mapParam);
				}
			} else {
				if("2003".equals(mapParam.get("muCd").toString())) {
					rs = fixedAssetsListDAO.selectMapTmCostCenter(mapParam);
				} else {
					rs = fixedAssetsListDAO.selectCostCenter(mapParam);
				}
			}
			//recoredset카피
			cprs = rs;
			
			for (int i = 0 ; i < rs.size() ; i++) {
				Record r = rs.get(i);
				
				FixedAssetsRequest fixedAssetsRequest = new FixedAssetsRequest();
				fixedAssetsRequest.setCcCd(r.getString("ccCd"));
				fixedAssetsRequest.setBaseMonth(mapParam.get("baseMm").toString());
				
				if (mapParam.containsKey("assetsKind") && !"".equals(mapParam.get("assetsKind").toString())) {
					fixedAssetsRequest.setAssetsKind(mapParam.get("assetsKind").toString());
				}
				
				reqList.add(fixedAssetsRequest);
			}
		}
		
		EAIResponse res = eaiService.call(reqList);
		
		if (res.isSuccess()) {
			resList = res.getListMap();
		} else {
			logger.debug(res.getErrorCode() + " / " + res.getErrorMsg());
			if (res.getErrorCode() == -1) {
				logger.debug("조회된 결과가 없습니다.");
			} else {
				throw super.processException("eai.exception");	
			}
		}
		
		//팀명매핑
		String strccCd = "", strtmCd = "", strtmNm = "";
		for (int i = 0 ; i < resList.size() ; i++) {
			strccCd = resList.get(i).get("ccCd").toString();
			for (int j = 0 ; j < cprs.size() ; j++) {
				Record r = cprs.get(j);
				if(strccCd.substring(4, 10).equals(r.getString("ccCd"))) {
					strtmCd = r.getString("tmCd");
					strtmNm = r.getString("tmNm");
					resList.get(i).put("tmCd", strtmCd);
					resList.get(i).put("tmNm", strtmNm);
					break;
				}
			}
		}
		
		return resList;
	}

}
