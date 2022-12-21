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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sm.saa.service.AccdArOccurReptService;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 사고채권발생보고하는 AccdArOccurRept Controller
 *
 * @ClassName AccdArOccurReptController.java
 * @Description AccdArOccurReptController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.04.29    최종덕        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 최종덕
 * @since 2015.04.29
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/sm/saa/accdArOccurRept/")
public class AccdArOccurReptController extends DefaultController {

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /** AccdArOccurReptService Bean 생성 */
    @Resource(name = "/sm/saa/accdArOccurReptService")
    private AccdArOccurReptService accdArOccurReptService;

    /**
     * 사고채권발생보고 목록을 조회한다.
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

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsGrdlist      = null;
        RecordSet rsHdrDealDesc  = null;

        // 사고채권을(를) 조회한다.
        parameter.get("ds_search").get(0).put("hdrGubun", "1");
        rsGrdlist   = accdArOccurReptService.selectList(parameter.get("ds_search").get(0));

        // 거래내역 헤더
        rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsSearchOutput", rsGrdlist);
        super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 식재 업장정보를  조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectSaupNoList.xdo")
    public ModelAndView selecSaupNotList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet saupNo      = null;
        //RecordSet rsHdrDealDesc  = null;

        // 식재 업장정보 조회한다.
        //parameter.get("ds_search").get(0).put("hdrGubun", "1");
        saupNo   = accdArOccurReptService.selectSaupNoList(parameter.get("ds_upjang").get(0));

        // 거래내역 헤더
        //rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsSaupNo", saupNo);
        //super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 업장정보를 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectUpjang.xdo")
    public ModelAndView selectUpjang(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsUpjang = null;

        // 업장정보
        rsUpjang = accdArOccurReptService.selectUpjang(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsUpjang", rsUpjang);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 거래처 채권금액을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectCustInfo.xdo")
    public ModelAndView selectCustInfo(
    		@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	
    	//XPLATFORM에 결과를 전달할 객체 생성
    	ModelAndView mav = super.createModelAndView();
    	
    	//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
    	Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
    	
    	RecordSet rsCust = null;
    	if(parameter.get("ds_cond").get(0).get("muCd").equals("2004")){ // 식재일때
    		// 거래처 채권 금액
    		rsCust = accdArOccurReptService.selectCustInfoFms(parameter.get("ds_cond").get(0));
    	}else{
    		// 거래처 채권 금액
    		rsCust = accdArOccurReptService.selectCustInfo(parameter.get("ds_cond").get(0));
    	}
    	
    	
    	//XPlatform으로 넘겨줄 Dataset을 설정한다.
    	super.addOutDataSet(mav, "rsCust", rsCust);
    	
    	//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 채권정보를 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectARInfo.xdo")
    public ModelAndView selectARInfo(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsDebt         = null;
        RecordSet rsDambo        = null;
        RecordSet rsLegal        = null;
        RecordSet rsHdrDealDesc  = null;
        RecordSet rsDealDesc     = null;
        List<Map> fileList       = null;

        // 담보
        rsDambo       = accdArOccurReptService.selectDambo(parameter.get("ds_search").get(0));

        // 채무자
        rsDebt        = accdArOccurReptService.selectDebt(parameter.get("ds_search").get(0));

        // 법적조치
        rsLegal       = accdArOccurReptService.selectLegal(parameter.get("ds_search").get(0));

        // 거래내역 헤더
        parameter.get("ds_search").get(0).put("hdrGubun", "1");
        rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        // 거래내역
        rsDealDesc    = accdArOccurReptService.selectDealDesc(parameter.get("ds_search").get(0));

        //첨부파일 참조일련번호를 얻는다.
        String strRefSeq = LimsUtil.checkNull(parameter.get("ds_search").get(0).get("fileId"));

        //첨부파일 조회 Service 호출
        if(!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
        }

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsDebt.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsDebt", rsDebt);
        super.addOutDataSet(mav, "dsDambo", rsDambo);
        super.addOutDataSet(mav, "dsLegal", rsLegal);
        super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
        super.addOutDataSet(mav, "dsDealDesc", rsDealDesc);
        super.addOutDataSet(mav, "dsFile", fileList);   //첨부파일 정보

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    
    
    /**
     * 채권정보 중 거래내역의 조회년월 변경 후 거래내역을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectDealDescBtn.xdo")
    public ModelAndView selectDealDescBtn(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsHdrDealDesc  = null;
        RecordSet rsDealDesc     = null;

        // 거래내역 헤더
        parameter.get("ds_search").get(0).put("hdrGubun", "1");
        rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        // 거래내역
        rsDealDesc    = accdArOccurReptService.selectDealDesc(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
        super.addOutDataSet(mav, "dsDealDesc", rsDealDesc);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    /**
     * 채권정보 중 거래내역의 조회년월 변경 후 거래내역을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectDealDescBtnFs.xdo")
    public ModelAndView selectDealDescBtnFs(
    		@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
    	
    	//XPLATFORM에 결과를 전달할 객체 생성
    	ModelAndView mav = super.createModelAndView();
    	
    	//조회 조건 파라미터를 얻는다.
    	Map <String, Object> inVar = xpDTO.getInVariableMap();
    	
    	//XPlatform에서 넘어온 Dataset Parameter을 추출한다.
    	Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
    	
    	RecordSet rsHdrDealDesc  = null;
    	RecordSet rsDealDesc     = null;
    	
    	// 거래내역 헤더
    	parameter.get("ds_search").get(0).put("hdrGubun", "1");
    	rsHdrDealDesc = accdArOccurReptService.selectHdrDealDescFs(parameter.get("ds_search").get(0));
    	
    	// 거래내역
    	rsDealDesc    = accdArOccurReptService.selectDealDescFs(parameter.get("ds_search").get(0));
    	
    	//XPlatform으로 넘겨줄 Dataset을 설정한다.
    	super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
    	super.addOutDataSet(mav, "dsDealDesc", rsDealDesc);
    	
    	//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
    	return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
    
    
    
    
    
    
    
    /**
     * 거래내역을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectDealDesc.xdo")
    public ModelAndView selectDealDesc(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsHdrDealDesc  = null;
        RecordSet rsDealDesc     = null;

        // 거래내역 헤더
        parameter.get("ds_search").get(0).put("hdrGubun", "1");
        rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter.get("ds_search").get(0));

        // 거래내역
        rsDealDesc    = accdArOccurReptService.selectDealDesc(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsHdrDealDesc", rsHdrDealDesc);
        super.addOutDataSet(mav, "dsDealDesc", rsDealDesc);

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
            , @RequestParam(value="upjangCd", required=true) String strUpjangCd
            , @RequestParam(value="accdArNum", required=true) String strAccdArNum
            , @RequestParam(value="accdArSeq", required=true) String strAccdArSeq
            , @RequestParam(value="basisSyymm", required=true) String strBasisSyymm
            , @RequestParam(value="basisEyymm", required=true) String strBasisEyymm
            , @RequestParam(value="basisyymm", required=true) String strBasisyymm
            , @RequestParam(value="muCd", required=true) String strMuCd
            , @RequestParam(value="mainUpjangCd", required=true) String strMainUpjangCd
            , @RequestParam(value="maskAuth", required=true) String strMaskAuth
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();
        
        parameter.put("accdArNum", strAccdArNum);
        parameter.put("accdArSeq", strAccdArSeq);
        parameter.put("basisSyymm", strBasisSyymm);
        parameter.put("basisEyymm", strBasisEyymm);
        parameter.put("basisyymm", strBasisyymm);
        parameter.put("muCd", strMuCd);
        parameter.put("mainUpjangCd", strMainUpjangCd);
        parameter.put("maskAuth", strMaskAuth);
        parameter.put("hdrGubun", "1");
        if(parameter.get("muCd").equals("2004")){ // 식재일때
        	parameter.put("upjangCd", strCustCd);
        }else{
        	parameter.put("custCd", strCustCd);
        	parameter.put("upjangCd", strUpjangCd);
        	
        }
        //사고채권
        RecordSet rsGrdlist     = accdArOccurReptService.selectList(parameter);

        // 거래내역 헤더
        RecordSet rsHdrDealDesc = accdArOccurReptService.selectHdrDealDesc(parameter);

        if(parameter.get("muCd").equals("2004")){ // 식재일때
	        // 거래내역
	        RecordSet rsDealDesc    = accdArOccurReptService.selectDealDesc(parameter);
	        model.addAttribute("gwDealDescList", rsDealDesc);
        }else{ // 식재가 아닐때
        	// 거래내역
           RecordSet rsDealDesc    = accdArOccurReptService.selectDealDescFs(parameter);
           model.addAttribute("gwDealDescList", rsDealDesc);
        }
        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftInfo", rsGrdlist.get(0));
        model.addAttribute("gwHdrDealDescList", rsHdrDealDesc);

        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);

        //본문을 생성하는 JSP 호출
        return new ModelAndView("/gw/saa/AccdArOccurRept");
    }

    /**
     * 사고채권발생보고(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        
      //로그인 세션 정보 얻기
      LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"ADDR_ENC"}));

        //사고채권발생보고을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = accdArOccurReptService.saveList(param.get("ds_list"),param.get("ds_debt"), param.get("ds_dambo"), param.get("ds_legal"), param.get("ds_file"), loginDTO);

        //처리건수를 OutVariable에 설정한다.
        super.addOutVariable(mav, "fv_processCnt", processCnt);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 사고채권발생보고(을)를 Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("deleteList.xdo")
    public ModelAndView deleteList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest req) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        
      //로그인 세션 정보 얻기
      LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //사고채권발생보고을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = accdArOccurReptService.deleteList(param.get("ds_list"),param.get("ds_file"), loginDTO);

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

        accdArOccurReptService.saveSignInfo(param.get("ds_list"));

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }
}
