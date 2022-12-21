package com.hwfs.sm.srm.web;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.sc.cmn.service.AttachFileService;
import com.hwfs.sm.srm.service.SapSlipSendReptService;


 /**
 * SAP 전표 전송하는 SapSlipSendRept Controller
 * 
 * @ClassName SapSlipSendReptController.java
 * @Description SapSlipSendReptController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.06.19    JUN        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 JUN
 * @since 2015.06.19
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/srm/sapSlipSendRept/")
public class SapSlipSendReptController extends DefaultController {
	
	/** LogService */
//	private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;
    
	/** SapSlipSendReptService Bean 생성 */
	@Resource(name = "/sm/srm/sapSlipSendReptService")
	private SapSlipSendReptService sapSlipSendReptService;
	
	/**
	 * SAP 전표 전송 목록을 조회한다.
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("selectList.xdo")
	public ModelAndView selectList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		
		Map<String, Object> parameter = param.get("ds_search").get(0);
		
		//SAP 전표 전송 을(를) 조회한다.
		RecordSet rs = sapSlipSendReptService.selectList(parameter);

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_list", rs);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
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
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "selectGwSilpAttachFile.xdo")
    public ModelAndView selectGwSilpAttachFile (
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
            List<Map<String, Object>> gwSlipAttachList = new ArrayList<Map<String, Object>>();
            
            for (int i=0; i<attachList.size(); i++) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put ("fileName", (String)attachList.get(i).get("orgnlFileNm"));
                map.put ("filePath", propertiesService.getString("global.filerepository.path")
                                   + (String)attachList.get(i).get("relPath") +"/"
                                   + (String)attachList.get(i).get("saveFileNm"));

                gwSlipAttachList.add(map);
            }

            //Json 형식으로 변환하여 outVariable로 반환
            JSONArray jsonList = new JSONArray(gwSlipAttachList);
            addOutDataSet (mav, "fv_attachList", jsonList.toString());
        }
        else
            addOutDataSet (mav, "fv_attachList", "");

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return setResultSet (mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.
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
     * @throws Exception //makeGwSilpContent
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="slipNum", required=true) String arrSlipNum
            ) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

//        System.out.println("### arrSlipNum:"+arrSlipNum);		
        //전표번호 문자열 목록으로 넘기도록 수정(타입일치로 속도개선) 2018.07.25 김호석
        String [] arrSnum =  arrSlipNum.split(",");
		String SlipNumList = "";
		
		for (int i = 0 ; i < arrSnum.length ; i++) {
			
			if (i == 0) {
				SlipNumList = "'" + arrSnum[i] + "'";								
			} else {
				SlipNumList = SlipNumList + ",'" + arrSnum[i] + "'";
			}
		}
//		System.out.println("### arrSlipNum:"+SlipNumList);

        parameter.put("slipNum", SlipNumList); 	        
    	
        RecordSet rsGrdlist = sapSlipSendReptService.selectSilpList(parameter);

        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftList", rsGrdlist);
        
        //본문을 생성하는 JSP 호출
        return new ModelAndView("/gw/srm/SapSlipSendRept");
    }
    

    /**
     * 그룹웨어 상신을 위한 본문을 생성하여 연동한다.(계약관리)
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
     * @throws Exception //makeGwSilpContent
     */
    @RequestMapping(value = "makeGwDraftContent2.do")
    public ModelAndView makeGwDraftContent2 (HttpServletRequest request, Model model
            , @RequestParam(value="contractCd", required=true) String ContractCd
            , @RequestParam(value="sabun", required=true) String Sabun
            ) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        
        parameter.put("contractCd", ContractCd); 	
        parameter.put("sabun", Sabun); 	         

        RecordSet rsGrdlist = sapSlipSendReptService.selectContractList(parameter);

        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftList", rsGrdlist);
        
        //본문을 생성하는 JSP 호출
        return new ModelAndView("/gw/scz/ContractGwDraft"); 
    }

	/**
	 * 전자결재정보를 Update 처리한다.
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "saveSignInfo.xdo")
	public ModelAndView saveSignInfo(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		sapSlipSendReptService.saveSignInfo(parameter);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 전자결재정보를 Update 처리한다. (계약관리)
	 * <pre>
	 * - 업무 테이블에 Instance ID Update
	 * - 결재정보 공통 테이블에 결재정보 Insert or Update
	 * </pre>
	 *
	 * @param xpDTO
	 * @param req
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "saveSignInfo2.xdo")
	public ModelAndView saveSignInfo2(
			@Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_contract");

		sapSlipSendReptService.saveSignInfo2(parameter);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	/**
	 * 전표 SAP I/F 연동
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveSapIfcSlip.xdo")
	public ModelAndView saveSapIfcSlip(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_list");

		int processCnt = sapSlipSendReptService.saveSapIfcSlip(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}


	/**
	 * 전표취소 SAP I/F 연동
	 *
	 * @param xpDTO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveSapIfcCancelSlip.xdo")
	public ModelAndView saveSapIfcCancelSlip(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap list = param.get("ds_sapCancelList");

		int processCnt = sapSlipSendReptService.saveSapIfcCancelSlip(list);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 전표생성취소
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 처리결과를 전달
	 * @throws Exception
	 */
	@RequestMapping("cancelSlipList.xdo")
	public ModelAndView cancelSlipList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap parameter = param.get("ds_sapSlipCancelList");

		//전표생성취소
		String sRetVal = sapSlipSendReptService.cancelSlipList(parameter);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_retVal", sRetVal);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
		
}
