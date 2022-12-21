package com.hwfs.ft.ftp.web;

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
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.ft.ftp.service.ProposalService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

 /**
 * Authority 처리 Controller
 * <pre>
 * -구매 품의 메뉴 조회
 * -구매 품의 마스터을 조회한다.
 * </pre>
 * @ClassName ProposalController.java
 * @Description ProposalController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015. 02. 24.   KJJ        최초생성
 * </pre>
 * @author FC종합전산구축 : KJJ
 * @since 2015. 02. 24.
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
public class ProposalController extends DefaultController {

    /** LogService */
    private final Logger logger = LoggerFactory.getLogger (this.getClass());

    /** Authority Service */
    @Resource (name="/ft/ftp/proposalService")
    private ProposalService proposalService;

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /**
     * 품의서을 조회한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/selectPoOrderList.xdo")
    public ModelAndView selectPoOrderList(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = proposalService.selectPoOrderList(parameter.get("ds_search").get(0));					//구매 품의 마스터을 조회한다.

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_proposalList", rs);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
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
    @RequestMapping(value = "/ft/ftp/makeGwDraftContent.do")
    public ModelAndView makeGwDraftContent (HttpServletRequest request, Model model
            , @RequestParam(value="searchId", required=true) String strId
            , @RequestParam(value="entrySchdDate", required=true) String entrySchdDate
            , @RequestParam(value="svc", required=true) String svc
            , @RequestParam(value="title", required=false, defaultValue="") String strBodyTitle) throws Exception {

        logger.info("#####makeGwDraftContent#####");
        //상신 본문 데이터를 조회 - 업무에 맞게 조회
        Map<String, Object> parameter = new HashMap<String, Object>();

        logger.info("strId :"+strId);
        logger.info("entrySchdDate :"+entrySchdDate);
        parameter.put("poProposalNum", strId);
        parameter.put("entrySchdDate", entrySchdDate);

        RecordSet rs = proposalService.selectProposalDtl(parameter);					//구매 품의 마스터을 조회한다.

        RecordSet rs2 = proposalService.selectPoProposalItemDtlList(parameter);			//구매 품의 품목 상세를 조회한다.

        RecordSet rs3 = proposalService.selectPoProposalItemDtlSum(parameter);			//구매 품의 품목 SUM 조회

        logger.info("settleSchdDate :"+rs.get(0).getString("settleSchdDate"));
        //본문을 생성하는 JSP로 정보를 전달하기 위해 Model에 설정한다.
        model.addAttribute("gwDraftInfo", rs.get(0));
        model.addAttribute("gwDraftList", rs2);
        model.addAttribute("gwDraftSum", rs3);

        String mode = super.propertiesService.getString("run.mode");

        logger.info("mode :"+mode);

        if ( "server".equalsIgnoreCase(mode))	//운영
        {
            svc = svc.replace("hwfc.", "nfics.");	//운영에서 외부사용자 이미지 안나와는부분 수정
        }

        //본문 타이틀 설정
        model.addAttribute("gwDraftTitle", strBodyTitle);
        model.addAttribute("svc", svc);
        logger.info("svc :"+svc);

        //본문을 생성하는 JSP 호출
        String path  =  "";
        if ( "10".equals(rs.get(0).get("poType")) )		//수입
        {
            path = "/gw/ftp/ProposalGwIncomeDraft";
        }
        else	//내수
        {
            path = "/gw/ftp/ProposalGwDmtDraft";
        }
        return new ModelAndView(path);
    }

    /**
      * 품의 상신
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("/ft/ftp/proposalDraft.xdo")
    public ModelAndView proposalDraft(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception{
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = proposalService.proposalDraft(loginDTO, parameter.get("ds_search"), parameter.get("ds_proposalList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
      * 품의 삭제
      * <pre>
      *
      * </pre>
      *
      * @param xpDto XPlatformMapDTO
      * @param req HttpServletRequest
      * @return ModelAndView
      * @throws Exception
      */
    @RequestMapping("/ft/ftp/deletePoProposalMst.xdo")
    public ModelAndView deletePoProposalMst(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        int procCnt  = proposalService.deletePoProposalMst(loginDTO, parameter.get("ds_search"), parameter.get("ds_proposalList"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", procCnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 품의서을 조회한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/selectProposalDtl.xdo")
    public ModelAndView selectProposalDtl(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        logger.info("flag :::"+parameter.get("ds_search").get(0).get("flag"));
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = null;
        if ( "CALL".equals(parameter.get("ds_search").get(0).get("flag")))	//구매주문화면에서 불러오기 클릭시
        {
            rs = proposalService.selectCallProposalDtl(parameter.get("ds_search").get(0));					//구매 품의 마스터을 조회한다.
        } else
        {
            rs = proposalService.selectProposalDtl(parameter.get("ds_search").get(0));					//구매 품의 마스터을 조회한다.
        }

        parameter.get("ds_search").get(0).put("entrySchdDate", rs.get(0).get("entrySchdDate"));	  //통관예정일자(관세율 가져오기
        RecordSet rs1 = proposalService.selectPoProposalItemDtlList(parameter.get("ds_search").get(0));			//구매 품의 품목 상세를 조회한다.
        RecordSet rs2 = proposalService.selectPoProposalPayCondList(parameter.get("ds_search").get(0));			//구매 품의 지불 조건를 조회한다.
        RecordSet rs3 = proposalService.selectPoProposalBlckMarkCondList(parameter.get("ds_search").get(0));	//구매 품의 벌점 조건를 조회한다.

        //첨부파일 참조일련번호를 얻는다.
        String dealStructImgeSrlnum =rs.get(0).getString("dealStructImgeSrlnum");
        logger.info("dealStructImgeSrlnum ::"+dealStructImgeSrlnum);
        //첨부파일 조회 Service 호출
        List<Map> dealStructImgeSrlnumrRs = null;

        if ( dealStructImgeSrlnum != null )
        {
            dealStructImgeSrlnumrRs = attachFileService.selectList(dealStructImgeSrlnum);	  //거래 구조 이미지 일련번호 조회한다.
        }


        //첨부파일 참조일련번호를 얻는다.
        String strRefSeq =rs.get(0).getString("fileRefSrlNum");
        logger.info("strRefSeq ::"+strRefSeq);

        //첨부파일 조회 Service 호출
        List<Map> rs4 = null;

        if ( strRefSeq != null )
        {
            rs4 = attachFileService.selectList(strRefSeq);	  //구매주문 첨부문서를 조회한다.
        }


        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        if ( "CALL".equals(parameter.get("ds_search").get(0).get("flag")))	//구매주문화면에서 불러오기 클릭시
        {
            super.addOutDataSet(mav, "ds_poOrderInfo", rs);
            super.addOutDataSet(mav, "ds_itemList", rs1);
            super.addOutDataSet(mav, "ds_payList", rs2);
        } else
        {
            super.addOutDataSet(mav, "ds_proposalInfo", rs);
            super.addOutDataSet(mav, "ds_itemList", rs1);
            super.addOutDataSet(mav, "ds_payList", rs2);
            super.addOutDataSet(mav, "ds_blckMarkList", rs3);
        }
        super.addOutDataSet(mav, "ds_file", dealStructImgeSrlnumrRs);
        super.addOutDataSet(mav, "ds_file2", rs4);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
     }

    /**
     * 품의서을 등록한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping("/ft/ftp/saveProposalDtl.xdo")
    public ModelAndView saveProposalDtl(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO, HttpServletRequest request) throws Exception  {
        //ModeAndView를 생성한다.
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();
        LoginDTO loginDTO = (LoginDTO)SessionUtil.getLoginSession(request);
        List<Map<String, Object>> listMap  = proposalService.saveProposalDtl(
                loginDTO
                , parameter.get("ds_search")
                , parameter.get("ds_proposalInfo")
                , parameter.get("ds_itemList")
                , parameter.get("ds_payList")
                , parameter.get("ds_blckMarkList")
                , parameter.get("ds_file")
                , parameter.get("ds_file2")
                );

        logger.info("procCnt :"+listMap.get(0).get("procCnt"));
        logger.info("poProposalNum :"+listMap.get(0).get("poProposalNum"));

        //XPlatform으로 넘겨줄 Form Global Variable을 설정한다.
        super.addOutVariable(mav, "fv_iProcessCnt", listMap.get(0).get("procCnt"));
        super.addOutVariable(mav, "fv_poProposalNum", listMap.get(0).get("poProposalNum"));
        super.addOutVariable(mav, "fv_flag", "UPDATE");

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 품의서을 조회한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/selectProposalSearchPop.xdo")
    public ModelAndView selectProposalSearchPop(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        logger.info( "ds_search :"+parameter.get("ds_search").get(0));
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        RecordSet rs = proposalService.selectProposalSearchPop(parameter.get("ds_search").get(0));					//구매 품의 마스터을 조회한다.

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "ds_proposalList", rs);

        //ModelAndView를 설정한다.
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
    @RequestMapping(value = "/ft/ftp/selectGwDraftAttachFile.xdo")
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

        if (!"".equals(strRefSeq) ) {
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
logger.info("saveFileNm :"+(String)attachList.get(i).get("saveFileNm"));
                gwDraftAttachList.add(map);
                logger.info("saveFileNm2 :"+(String)attachList.get(i).get("saveFileNm"));
            }
            //Json 형식으로 변환하여 outVariable로 반환
            JSONArray jsonList = new JSONArray( gwDraftAttachList );
            addOutDataSet (mav, "fv_attachList", jsonList.toString());
            logger.info("saveFileNm3");
        }
        else
            addOutDataSet (mav, "fv_attachList", "");

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return setResultSet (mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 환율을 조회한다.
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/getExchangeRate.xdo")
    public ModelAndView getExchangeRate(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Record rd = proposalService.getExchangeRate(parameter.get("ds_search").get(0));					//환율을 조회한다.
        logger.info( "rd :"+rd);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        String fvExchangeRate = "";
        String fvExchangeRateBasis = "";
        if ( rd != null )
        {
            logger.info( "exchangeRate :"+rd.get("exchangeRate"));
            fvExchangeRate = rd.get("exchangeRate").toString();
            fvExchangeRateBasis = rd.get("exchangeRateBasis").toString();
        }

        super.addOutVariable(mav, "fv_exchangeRate", fvExchangeRate);
        super.addOutVariable(mav, "fv_exchangeRateBasis", fvExchangeRateBasis);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
     }

    /**
     * 단위변경시 단위에 해당하는 실단위 가져오기
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/getUnitInfo.xdo")
    public ModelAndView getUnitInfo(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Record rd = proposalService.getUnitInfo(parameter.get("ds_search").get(0));
        logger.info( "rd :"+rd);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        String set1 = "";
        if ( rd != null )
        {
            logger.info( "set1 :"+rd.get("set1"));
            set1 = rd.get("set1").toString();
        }

        super.addOutVariable(mav, "fv_set1", set1);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
     }

    /**
     * 수수료구분 변경시 계정정보 가져오기
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/getAccCdInfo.xdo")
    public ModelAndView getAccCdInfo(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Record rd = proposalService.getAccCdInfo(parameter.get("ds_search").get(0));
        logger.info( "rd :"+rd);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        String acctCd = "";
        String acctNm = "";
        String blType = "";
        String drAcctCd = "";
        String crAcctCd = "";
        String commClassNm = "";

        String attr03 = "";
        String attr03Nm = "";

        if ( rd != null )
        {
            logger.info( "acctCd :"+rd.get("acctCd"));
            acctCd = rd.get("acctCd").toString();
            acctNm = rd.get("acctNm").toString();
            blType = rd.get("blType").toString();

            drAcctCd = rd.get("drAcctCd").toString();
            crAcctCd = rd.get("crAcctCd").toString();
            commClassNm = rd.get("commClassNm").toString();

            attr03 =  LimsUtil.checkNull(rd.get("attr03"),"");
            attr03Nm = LimsUtil.checkNull(rd.get("attr03Nm"),"");

        }

        super.addOutVariable(mav, "fv_acctCd", acctCd);
        super.addOutVariable(mav, "fv_acctNm", acctNm);
        super.addOutVariable(mav, "fv_blType", blType);
        super.addOutVariable(mav, "fv_drAcctCd", drAcctCd);
        super.addOutVariable(mav, "fv_crAcctCd", crAcctCd);
        super.addOutVariable(mav, "fv_commClassNm", commClassNm);
        super.addOutVariable(mav, "fv_attr03", attr03);
        super.addOutVariable(mav, "fv_attr03Nm", attr03Nm);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
     }

    /**
     * BL번호 중복체크
     * <pre>
     *
     * </pre>
     *
     * @param xpDto XPlatformMapDTO
     * @param req HttpServletRequest
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/ft/ftp/chkDupBlnum.xdo")
    public ModelAndView chkDupBlnum(
            @Bind(id="", type=XplatformMapDTO.class)XplatformMapDTO xpDto
          , HttpServletRequest req) throws Exception {
        ModelAndView mav = super.createModelAndView();
        //조회 조건 파라미터를 얻는다.
        Map<String, DataSetMap> parameter = xpDto.getInDataSetMap();
        //XPlatform에서 넘어온 DataSet Parameter을 추출한다.
        Record rd = proposalService.chkDupBlnum(parameter.get("ds_search").get(0));
        logger.info( "rd :"+rd);

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        String cnt = "";
        if ( rd != null )
        {
            logger.info( "cnt :"+rd.get("cnt"));
            cnt = rd.get("cnt").toString();
        }

        super.addOutVariable(mav, "fv_blNumCnt", cnt);

        //ModelAndView를 설정한다.
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
     }
}
