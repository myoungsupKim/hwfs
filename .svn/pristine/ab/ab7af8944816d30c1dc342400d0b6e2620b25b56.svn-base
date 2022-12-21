package com.hwfs.rc.rrm.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.rc.rrm.service.SmlRecipeDetailedMgntService;
import com.hwfs.sc.cmn.dto.LoginDTO;


/**
 * 가상레시피 상세를 관리하는 SmlRecipeDetailedMgnt Controller
 *
 * @ClassName SmlRecipeDetailedMgntController.java
 * @Description SmlRecipeDetailedMgntController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.03    유인찬        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 유인찬
 * @since 2015.04.03
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@SuppressWarnings("unchecked")
@RequestMapping("/rc/rrm/smlRecipeDetailedMgnt/")
public class SmlRecipeDetailedMgntController extends DefaultController
{
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** SmlRecipeDetailedMgntService Bean 생성 */
	@Resource(name = "/rc/rrm/smlRecipeDetailedMgntService")
	private SmlRecipeDetailedMgntService smlRecipeDetailedMgntService;

	/**
	 * 가상레시피 목록을 조회한다.
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

		// 가상레시피를 조회한다.
		RecordSet rs = smlRecipeDetailedMgntService.selectList(parameter);

		// XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 가상레시피 상세 목록을 조회한다.
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
	@RequestMapping("selectDtlList.xdo")
	public ModelAndView selectDtlList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception
	{
		// XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		// XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		// 조회 조건 파라미터를 얻는다.
		//Map <String, Object> inVar = xpDTO.getInVariableMap();

		// Dataset에서 첫번째 행의 정보만 추출한다.
		Map<String, Object> parameter = param.get("ds_search").get(0);

		// 가상레시피 상세를 조회한다.
		RecordSet rs = smlRecipeDetailedMgntService.selectDtlList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		// 전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	/**
	 * 가상레시피 상세를 Insert/Update/Delete 처리한다.
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
	public ModelAndView saveList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest request) throws Exception
	{
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(request);

		// XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap cond = param.get("ds_copy");
		DataSetMap list = param.get("ds_list");
		DataSetMap dtList = param.get("ds_dtlList");

		// 가상레시피 상세를 Insert/Update/Delete 처리한다.
		int processCnt = smlRecipeDetailedMgntService.saveList(cond, list, dtList, loginDTO);

		// 처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		if( processCnt == -1 )
		{
			return super.setResultSet(mav, DefaultConsts.ERR_CODE, "이미 등록된 재료가 있습니다.");
		}
		else
		{
			//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
			return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
		}
	}
}