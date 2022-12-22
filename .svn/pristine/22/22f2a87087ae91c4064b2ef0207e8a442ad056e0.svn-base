package com.hwfs.ma.mak.web;

import hone.core.util.record.Record;
import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.ma.mak.service.DriveMgntService;
import com.hwfs.sc.cmn.service.AttachFileService;


 /**
 * DriveMgnt Controller
 * 
 * @ClassName DriveMgntController.java
 * @Description DriveMgntController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2019.02.11    kihoon        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 kihoon
 * @since 2019.02.11
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/ma/mak/driveMgnt/")
public class DriveMgntController extends DefaultController {
	
	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** DriveMgntService Bean 생성 */
	@Resource(name = "/ma/mak/driveMgntService")
	private DriveMgntService driveMgntService;
	
    /** FileAttach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;
	
	/**
	 * 차량목록을 조회한다.
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
	@RequestMapping("selectCarList.xdo")
	public ModelAndView selecCarList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		@SuppressWarnings("unchecked")
		RecordSet rs = driveMgntService.selectCarList(param.get("ds_search").get(0));

		super.addOutDataSet(mav, "ds_list", rs);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

	@RequestMapping("selectCarDetail.xdo")
	public ModelAndView selecCarDetail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map <String, DataSetMap> param = xpDTO.getInDataSetMap();
		logger.debug(param.get("ds_search").get(0).get("attachInfo").toString()); 
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		List<Map> lst = attachFileService.selectList(param.get("ds_search").get(0).get("attachInfo").toString());
		
		super.addOutDataSet(mav, "ds_list", lst);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * Insert/Update/Delete 처리한다.
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

		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
	
		DataSetMap paramList = param.get("ds_list");

		int processCnt = driveMgntService.saveList(paramList);

		super.addOutVariable(mav, "fv_processCnt", processCnt);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	
	/**
	 * Insert/Update/Delete 처리한다.
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
	
	@RequestMapping("saveListDetail.xdo")
	public ModelAndView saveDetail(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap paramData = param.get("ds_search");
		DataSetMap paramFile = param.get("ds_list");

		int processCnt = driveMgntService.saveListDetail(paramData, paramFile);

		super.addOutVariable(mav, "fv_processCnt", processCnt);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
     * 김재섭 요청으로 김민수 개발
     * <pre>
     * - RequestMapping은 .do로 해야 한다.
     * - 상신을 위한 본문은 DB에서 쿼리하여 JSP를 이용하여 동적으로 HTML 본문을 만든다.
     * - JSP 본문 양식은 WEB-INF/jsp에서 관리한다.
     * - 본문 title 파라미터는 공통에서 전달한다.
     * </pre>
     *
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent(HttpServletRequest request, Model model,
            @RequestParam(value = "mgmtSabun", required = true) String mgmtSabun,
            @RequestParam(value = "carClass", required = true) String carClass,
            @RequestParam(value = "carNumber", required = true) String carNumber,
            @RequestParam(value = "title", required = false, defaultValue = "") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        parameter.put("mgmtSabun", mgmtSabun);
        parameter.put("carClass", carClass);
        parameter.put("carNumber", carNumber);
        Record rs = driveMgntService.selectGwDraftMst(parameter); // 마스터을 조회한다.

        model.addAttribute("gwDraftMaster", rs);
        model.addAttribute("gwDraftTitle", strBodyTitle);

        //본문을 생성하는 JSP 호출
        String path = "/gw/mak/CarMasterGwDraft";
        // HWRC_FC_CAR_MASTER
        return new ModelAndView(path);
    }
    
    /**
	 * 그룹웨어 상신을 위한 첨부파일 목록을 얻는다.
	 * <pre>
	 * - 첨부 파일은 서버에 존재해야 하며, 파일이 있는 Full Path로 설정해야 한다.
	 * - 목록은 json 형태로 생성한다.
	 * </pre>
	 *
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "selectGwDraftAttachFile.xdo")
	public ModelAndView selectGwDraftAttachFile (
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM View를 위한 객체 생성
		ModelAndView mav = createModelAndView ();

		//조회 조건 파라미터를 얻는다.
		Map <String, Object> inVar = xpDTO.getInVariableMap();

		//첨부파일 참조일련번호를 얻는다.
		String strRefSeq = "";
		if (inVar.get("refSeq") != null)
			strRefSeq =  inVar.get("refSeq").toString();

		if (!strRefSeq.equals("")) {
			//첨부파일 조회 Service 호출
			List<Map> attachList = attachFileService.selectList(strRefSeq);

			//첨부파일정보는 파일이 있는 실제 위치를 설정해야 함 : 업무에 맞게 설정
			//"fileName", "filePath" 명칭은 고정
			List<Map<String, Object>> gwDraftAttachList = new ArrayList<Map<String, Object>>();
			for (int i=0; i<attachList.size(); i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put ("fileName", (String)attachList.get(i).get("orgnlFileNm"));
				map.put ("filePath", propertiesService.getString("global.filerepository.path")
								   + (String)attachList.get(i).get("relPath") +"/"
								   + (String)attachList.get(i).get("saveFileNm"));

				gwDraftAttachList.add(map);
			}
			//Json 형식으로 변환하여 outVariable로 반환
			JSONArray jsonList = new JSONArray( gwDraftAttachList );
			addOutDataSet (mav, "fv_attachList", jsonList.toString());
		}
		else
			addOutDataSet (mav, "fv_attachList", "");

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return setResultSet (mav, DefaultConsts.OK_CODE, "");
	}
	
	@RequestMapping("saveSignInfo.xdo")
	public ModelAndView saveSignInfo(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
	
		DataSetMap paramList = param.get("ds_list");

		int processCnt = driveMgntService.updateSignInfo(paramList);

		super.addOutVariable(mav, "fv_processCnt", processCnt);

		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
}
