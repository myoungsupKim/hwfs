package com.hwfs.rc.rrm.web;

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
import com.hwfs.rc.rrm.service.RecipeBatchChangeMgntService;


 /**
 * 업장 레시피 자재 일괄 변경 이력을 관리하는 RecipeBatchChangeMgnt Controller
 * 
 * @ClassName RecipeBatchChangeMgntController.java
 * @Description RecipeBatchChangeMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2016.07.18    백승현        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 백승현
 * @since 2016.07.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@SuppressWarnings("unchecked")
@RequestMapping("/rc/rrm/recipeBatchChangeMgnt/")
public class RecipeBatchChangeMgntController extends DefaultController
{
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** RecipeListServiceService Bean 생성 */
	@Resource(name = "/rc/rrm/recipeBatchChangeMgntService")
	private RecipeBatchChangeMgntService recipeBatchChangeMgntService;
	
	/**
	 * 업장 레시피 자재 일괄 변경 이력을 조회한다.
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
	public ModelAndView selectList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
	{
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// 조회 조건 파라미터를 얻는다.
		//Map <String, Object> inVar = xpDTO.getInVariableMap();
		
		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 업장 레시피 자재 일괄 변경 이력을 조회한다.
		RecordSet rs = recipeBatchChangeMgntService.selectList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장 레시피 자재 일괄 변경 상세이력을 조회한다.
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
	public ModelAndView selectDetailList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
	{
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		//Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

		// 조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		//Map<String, Object> parameter = param.get("ds_search").get(0);
		
		// 업장 레시피 자재 일괄 변경 상세이력을 조회한다.
		RecordSet rs = recipeBatchChangeMgntService.selectDetailList(inVar);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장 레시피 품목 일괄 변경 요청을 승인처리한다.
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

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		// 업장 레시피 품목 일괄 변경 요청을 승인처리한다.
		int processCnt = recipeBatchChangeMgntService.saveList(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 업장 레시피 품목 일괄 변경 요청을 요청취소 처리한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("cancelList.xdo")
	public ModelAndView cancelList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		// 업장 레시피 품목 일괄 변경 요청을 승인처리한다.
		int processCnt = recipeBatchChangeMgntService.cancelList(parameter);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}