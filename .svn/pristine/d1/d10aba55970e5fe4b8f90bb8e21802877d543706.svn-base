package com.hwfs.sm.saa.web;

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
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sm.saa.service.SalsNonOccurReasonReptService;
import com.hwfs.sc.cmn.service.AttachFileService;


 /**
 * 매출미발생사유 및 계획을 관리하는 SalsNonOccurReasonRept Controller
 * 
 * @ClassName SalsNonOccurReasonReptController.java
 * @Description SalsNonOccurReasonReptController Class 
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.05.06    김예진        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 김예진
 * @since 2015.05.06
 * @version 1.0
 * @see 
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/salsNonOccurReasonRept/")
public class SalsNonOccurReasonReptController extends DefaultController {

	/** SalsNonOccurReasonReptService Bean 생성 */
	@Resource(name = "/sm/saa/salsNonOccurReasonReptService")
	private SalsNonOccurReasonReptService salsNonOccurReasonReptService;
	
	/** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;
    
	/**
	 * 매출 거래처 목록을 조회한다.
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
	@RequestMapping("selectCustList.xdo")
	public ModelAndView selectCustList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		//매출미발생사유 및 계획 을(를) 조회한다.
		RecordSet custList = salsNonOccurReasonReptService.selectCustList(parameter.get("ds_search").get(0));

		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_custList", custList);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 매출 거래처 따른 조회 목록을 조회한다.
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
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		List<Map> fileList       = null;
		
		//매출미발생사유 및 계획 을(를) 조회한다.
		RecordSet damboList = salsNonOccurReasonReptService.selectDamboList(parameter.get("ds_search").get(0));
		//RecordSet arNonoccurList = salsNonOccurReasonReptService.selectArNonoccurList(parameter.get("ds_search").get(0));
		//RecordSet hdrDealDesc = salsNonOccurReasonReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));
		//RecordSet dealDescList = salsNonOccurReasonReptService.selectDealDescList(parameter.get("ds_search").get(0));
		
		//첨부파일 참조일련번호를 얻는다.
        String strRefSeq = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("fileId"));

        //첨부파일 조회 Service 호출
        if(!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
        }
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_damboList", damboList);
		//super.addOutDataSet(mav, "ds_arNonoccurList", arNonoccurList);
		//super.addOutDataSet(mav, "ds_hdrDealDesc", hdrDealDesc);
		//super.addOutDataSet(mav, "ds_dealDescList", dealDescList);
		super.addOutDataSet(mav, "ds_fileList", fileList);   //첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 매출 거래처 따른 거래 목록을 조회한다.
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
	@RequestMapping("selectDealList.xdo")
	public ModelAndView selectDealList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		List<Map> fileList       = null;
		
		//매출미발생사유 및 계획 을(를) 조회한다.
		RecordSet hdrDealDesc = salsNonOccurReasonReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));
		RecordSet dealDescList = salsNonOccurReasonReptService.selectDealDescList(parameter.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_hdrDealDesc", hdrDealDesc);
		super.addOutDataSet(mav, "ds_dealDescList", dealDescList);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 매출 거래처 따른 거래 목록을 조회한다.
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
	@RequestMapping("selectDealListFs.xdo")
	public ModelAndView selectDealListFs(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
		Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
		
		List<Map> fileList       = null;
		
		//매출미발생사유 및 계획 을(를) 조회한다.
		RecordSet hdrDealDesc = salsNonOccurReasonReptService.selectHdrDealDescFs(parameter.get("ds_search").get(0));
		RecordSet dealDescList = salsNonOccurReasonReptService.selectDealDescListFs(parameter.get("ds_search").get(0));
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_hdrDealDesc", hdrDealDesc);
		super.addOutDataSet(mav, "ds_dealDescList", dealDescList);
		
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
     * @throws Exception
     */
    @RequestMapping(value = "makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="custCd", required=true) String strCustCd
            , @RequestParam(value="upjangCd", required=true) String strupjangCd
            , @RequestParam(value="accdArNum", required=true) String strAccdArNum
            , @RequestParam(value="accdArSeq", required=true) String strAccdArSeq
            , @RequestParam(value="basisSyymm", required=true) String strBasisSyymm
            , @RequestParam(value="basisEyymm", required=true) String strBasisEyymm
            , @RequestParam(value="basisAyymm", required=true) String strBasisAyymm
            , @RequestParam(value="muCd", required=true) String strMuCd
            , @RequestParam(value="mainUpjangCd", required=true) String strMainUpjangCd
            , @RequestParam(value="maskAuth", required=true) String strMaskAuth
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        parameter.put("custCd", strCustCd);
        parameter.put("upjangCd", strupjangCd);
        parameter.put("accdArNum", strAccdArNum);
        parameter.put("accdArSeq", strAccdArSeq);
        parameter.put("basisSyymm", strBasisSyymm);
        parameter.put("basisEyymm", strBasisEyymm);
        parameter.put("basisAyymm", strBasisAyymm);
        parameter.put("muCd", strMuCd);
        parameter.put("mainUpjangCd", strMainUpjangCd);
        parameter.put("maskAuth", strMaskAuth);
        
        //거래처현황
        RecordSet custList     = salsNonOccurReasonReptService.selectCustList(parameter);

        //매출미발생 사유
        RecordSet arNonoccurList = salsNonOccurReasonReptService.selectArNonoccurList(parameter);

        
        // 거래내역 헤더
        RecordSet hdrDealDesc = salsNonOccurReasonReptService.selectHdrDealDesc(parameter);
        RecordSet dealDescList = null;
        RecordSet dealDescListFs = null;
        if(parameter.get("muCd").equals("2004")){ // 식재
	        // 거래내역
	        dealDescList    = salsNonOccurReasonReptService.selectDealDescList(parameter);
	        model.addAttribute("gwDealDescList", dealDescList);
        }else{ // 식재가 아닐때
        	// 거래내역
	        dealDescListFs    = salsNonOccurReasonReptService.selectDealDescListFs(parameter);
	        model.addAttribute("gwDealDescList", dealDescListFs);
        }
        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftInfo", custList.get(0));
        model.addAttribute("gwArNonoccurList", arNonoccurList.get(0));
        model.addAttribute("gwHdrDealDescList", hdrDealDesc);
        
        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);

        //본문을 생성하는 JSP 호출
        return new ModelAndView("/gw/saa/SalsNonOccurReasonRept");
    }

	/**
	 * 매출미발생사유 및 계획(을)를 Insert/Update/Delete 처리한다.
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
		DataSetMap damboList = param.get("ds_damboList");
		DataSetMap arNonoccurList = param.get("ds_arNonoccurList");
		DataSetMap fileList = param.get("ds_fileList");

		//매출미발생사유 및 계획을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = salsNonOccurReasonReptService.saveList(damboList,arNonoccurList,fileList);

		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);

		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}
	
	/**
	 * 매출미발생사유 및 계획(을)를 Delete 처리한다.
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
	@RequestMapping("deleteList.xdo")
	public ModelAndView deleteList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
		
		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();
		
		//XPlatform에서 넘어온 Dataset Parameter를 추출한다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		DataSetMap arNonoccurList = param.get("ds_arNonoccurList");
		DataSetMap fileList = param.get("ds_fileList");
		
		//매출미발생사유 및 계획을(를) 등록, 수정, 삭제 처리한다.
		int processCnt = salsNonOccurReasonReptService.deleteList(arNonoccurList,fileList);
		
		//처리건수를 OutVariable에 설정한다.
		super.addOutVariable(mav, "fv_processCnt", processCnt);
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
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

        salsNonOccurReasonReptService.saveSignInfo(param.get("ds_arNonoccurList"));

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
