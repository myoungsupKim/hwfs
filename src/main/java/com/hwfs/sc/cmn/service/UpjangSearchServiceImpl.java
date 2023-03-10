package com.hwfs.sc.cmn.service;

import hone.core.util.record.RecordSet;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.hwfs.cmn.defaults.DefaultServiceImpl;
import com.hwfs.sc.cmn.dao.UpjangSearchDAO;
import com.hwfs.sc.cmn.dto.LoginDTO;

/**
 * 업장검색하는 UpjangSearch Service Implementation
 *
 * @ClassName UpjangSearchServiceImpl.java
 * @Description UpjangSearchServiceImpl Class
 * @Modification-Information <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.19    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 : COM 김재섭
 * @since 2015.03.19
 * @version 1.0
 * @see <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Service("/sc/cmn/upjangSearchService")
public class UpjangSearchServiceImpl extends DefaultServiceImpl implements
		UpjangSearchService {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	/** UpjangSearchDAO Bean 생성 */
	@Resource(name = "/sc/cmn/upjangSearchDAO")
	private UpjangSearchDAO upjangSearchDAO;

	/**
	 * 업장검색 목록을 조회한다.
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
	public RecordSet selectList(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception {

		Map<String, Object> parameter = mapParam;
		if ("ScoAuthLevel".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("ScoAuthLevel 수행");
			//업장Component를 Main Upjang으로 사용할 경우에는 RoleSetId를 강제적으로 변경한다.
			if ("Y".equals(mapParam.get("isMainUpjang").toString())) {
				parameter.put("roleSetId", "FmsMainUpjangAuthLevel");
			}

			//업장의 Component를 Sub Upjang으로 사용할 경우에는 RoleSetId를 강제적으로 변경한다.
			if ("Y".equals(mapParam.get("isSubUpjang").toString())) {
				parameter.put("roleSetId", "FmsUpjangAuthLevel");
			}
		} else if ("OutletUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("OutletUpjang 수행");
		} else if ("ScoUpjangMst".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("ScoUpjangMst 수행");
		} else if ("ScoAuthLevel01".equals(mapParam.get("roleSetId").toString())) {
			parameter = this.setScoAuthLevel01(mapParam, loginDTO);
		} else if ("FmsMainUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("FmsMainUpjang 수행");
		} else if ("FmsUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("FmsUpjang 수행");
		} else if ("ScoUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("ScoUpjang 수행");
		} else if ("StUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("StUpjang 수행");
		} else if ("VatUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("StUpjang 수행");
		} else if ("InlineFmsUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("소속의 메인업장에 해당되는 업장들 조회");
		} else if ("CostCenter".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("CC 조회");
		} else if ("BrandUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("BrandUpjang 수행");
		} else if ("BrandMainUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("BrandMainUpjang 수행");
		} else if ("HnrUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("HnrUpjang 수행");
		} else if ("MartUpjang".equals(mapParam.get("roleSetId").toString())) {
			logger.debug("MartUpjang 수행");
		} else {
			throw processException("sc.cmn.upjangSearch.exception");
		}
		// Parameter에 대한 Log를 기록한다.
		logParameter(parameter);

		return upjangSearchDAO.selectList(parameter);
	}

	/**
	 * selectPartList 설명
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param mapParam
	 * @return
	 * @throws Exception
	 * @see com.hwfs.sc.cmn.service.UpjangSearchService#selectPartList(java.util.Map)
	*/
	@Override
	public RecordSet selectPartList(Map<String, Object> mapParam) throws Exception {
		return upjangSearchDAO.selectPartList(mapParam);
		
	}
	
	/**
	 * RoleSetId가 ScoAuthLevel01인 경우에 대한 기본 Parameter를 설정한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private Map<String, Object> setScoAuthLevel01(
			Map<String, Object> parameter, LoginDTO loginDTO) throws Exception {
		parameter.put("gAuthLevel", loginDTO.getAuthLevel());
		parameter.put("gUpjang", loginDTO.getUpjang());
		parameter.put("gEmpNo", loginDTO.getSabun());
		parameter.put("gTmCd", loginDTO.getTmCd());

		return parameter;
	}

	/**
	 * Parameter의 값을 출력한다.
	 *
	 * <pre>
	 * 메소드 상세설명 작성(생략 가능)
	 * </pre>
	 *
	 * @param parameter
	 * @throws Exception
	 */
	private void logParameter(Map<String, Object> parameter) throws Exception {
		Set<String> key = parameter.keySet();
		Iterator<String> it = key.iterator();

		logger.debug("================================================================================");
		logger.debug(" Upjang Search Parameter");
		logger.debug("================================================================================");
		while (it.hasNext()) {
			String k = it.next();
			logger.debug(" " + k + " : " + parameter.get(k));
		}
		logger.debug("================================================================================");
	}
	
	/**
	 * 2020.06.11 김명섭 월별손익보고서(수주) 팀 조회
	 * 수주물건 등록 담당부서(팀) 업장정보를 조회한다.
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
	public RecordSet selectAccobjList(Map<String, Object> mapParam, LoginDTO loginDTO)
			throws Exception {

		return upjangSearchDAO.selectAccobjList(mapParam);

	}
	
}
