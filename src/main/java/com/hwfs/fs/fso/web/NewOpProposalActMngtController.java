package com.hwfs.fs.fso.web;

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
import com.hwfs.fs.fso.service.NewOpProposalActMngtService;


 /**
 * 신규운영품의 대비 실적관리하는 NewOpProposalActMngt Controller
 * 
 * @ClassName NewOpProposalActMngtController.java
 * @Description NewOpProposalActMngtController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.07.15    최문규        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최문규
 * @since 2015.07.15
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fso/newOpProposalActMngt/")
public class NewOpProposalActMngtController extends DefaultController {
	
	/** NewOpProposalActMngtService Bean 생성 */
	@Resource(name = "/fs/fso/newOpProposalActMngtService")
	private NewOpProposalActMngtService newOpProposalActMngtService;
	
	/**
	 * 신규운영품의 대비 실적관리 목록을 조회한다.
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
	@RequestMapping("selectNewOpProposalActMngtList.xdo")
	public ModelAndView selectNewOpProposalActMngtList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//신규운영품의 대비 실적관리 을(를) 조회한다.
		@SuppressWarnings("unchecked")
		RecordSet rs = newOpProposalActMngtService.selectNewOpProposalActMngtList(param.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_proposalPlanList", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 신규운영품의 대비 실적관리 업장별실적및 손익계산서를 상세조회한다.
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
	@RequestMapping("selectDetailList.xdo")
	public ModelAndView selectDetailList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		//업장 정보를 조회한다.
		@SuppressWarnings("unchecked")
		Map<String, RecordSet> rs = newOpProposalActMngtService.selectDetailList(param.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_accOrderPlanList", rs.get("accOrderPlan"));
		super.addOutDataSet(mav, "ds_plinvoiceList", rs.get("plinvoice"));
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 신규운영품의 대비 실적관리(을)를 Insert/Update/Delete 처리한다.
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
	@RequestMapping("saveNewOpProposalActMngtList.xdo")
	public ModelAndView saveNewOpProposalActMngtList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_accOrderPlanList");

		//신규운영품의 대비 실적관리을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = newOpProposalActMngtService.saveNewOpProposalActMngtList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
}
