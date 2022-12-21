package com.hwfs.sc.scc.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.scc.service.OrgConfigService;


 /**
 * 조직에 대한 환경을 설정하는 OrgConfig Controller
 * 
 * @ClassName OrgConfigController.java
 * @Description OrgConfigController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.09.09    김재섭        최초생성
 * </pre>
 * @author FC종합전산구축 :  COM 김재섭
 * @since 2015.09.09
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sc/scc/orgConfig/")
public class OrgConfigController extends DefaultController {
	
	/** LogService */
	//private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** OrgConfigService Bean 생성 */
	@Resource(name = "/sc/scc/orgConfigService")
	private OrgConfigService orgConfigService;
	
	/**
	 * 조직 환경 설정 목록을 조회한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조직 환경 설정 을(를) 조회한다.
		Map<String, RecordSet> orgConfig = orgConfigService.selectList();

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_orgConfig01", orgConfig.get("orgConfig01"));
		super.addOutDataSet(mav, "ds_orgConfig02", orgConfig.get("orgConfig02"));
		super.addOutDataSet(mav, "ds_orgConfig03", orgConfig.get("orgConfig03"));
		super.addOutDataSet(mav, "ds_orgConfig04", orgConfig.get("orgConfig04"));

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 조직 환경 설정(을)를 Insert/Update/Delete 처리한다.
	 * <pre>
	 * - 메소드 상세설명 작성(생략 가능)-->생략 시 이 부분 삭제할 것
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("saveList.xdo")
	public ModelAndView saveList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter01 = param.get("ds_orgConfig01");
		DataSetMap parameter02 = param.get("ds_orgConfig02");
		DataSetMap parameter03 = param.get("ds_orgConfig03");
		DataSetMap parameter04 = param.get("ds_orgConfig04");

		//조직 환경 설정을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = orgConfigService.saveList(parameter01, parameter02, parameter03, parameter04);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
