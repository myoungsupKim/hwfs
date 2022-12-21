package com.hwfs.fs.fse.web;

import hone.core.util.record.RecordSet;
import hone.online.web.bind.anno.Bind;
import hone.online.xplatform.map.DataSetMap;
import hone.online.xplatform.map.XplatformMapDTO;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.defaults.DefaultConsts;
import com.hwfs.cmn.defaults.DefaultController;
import com.hwfs.cmn.util.SessionUtil;
import com.hwfs.fs.fse.service.EventProcessInfoMgntService;
import com.hwfs.ls.cmn.util.LimsUtil;
import com.hwfs.sc.cmn.dto.LoginDTO;
import com.hwfs.sc.cmn.service.AttachFileService;

/**
 * 이벤트 신청정보 관리하는 EventProcessInfoMgnt Controller
 *
 * @ClassName EventProcessInfoMgntController.java
 * @Description EventProcessInfoMgntController Class
 * @Modification-Information
 * <pre>
 *    수정일       수정자              수정내용
 *  ----------   ----------   -------------------------------
 *  2015.03.18    남기빈        최초생성
 * </pre>
 * @author FC종합전산구축 :  통합영업 남기빈
 * @since 2015.03.18
 * @version 1.0
 * @see
 * <pre>
 *  Copyright (C) 2014 by HANWHA S&C CO.,LTD. All right reserved.
 * </pre>
 */
@Controller
@RequestMapping("/fs/fse/eventProcessInfoMgnt/")
public class EventProcessInfoMgntController extends DefaultController {

    /** EventProcessInfoMgntService Bean 생성 */
    @Resource(name = "/fs/fse/eventProcessInfoMgntService")
    private EventProcessInfoMgntService eventProcessInfoMgntService;

    /** File Attach Service Bean 생성 */
    @Resource(name = "/sc/cmn/attachFileService")
    private AttachFileService attachFileService;

    /**
     * 이벤트 진행정보 관리 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectGrdList.xdo")
    public ModelAndView selectGrdList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsCbo     = null;
        RecordSet rsTheme   = null;
        RecordSet rsGrdlist = null;
        RecordSet rsLclass  = null;
        RecordSet rsMclass  = null;
        RecordSet rsSclass  = null;

        //분류 콤보
        rsCbo = eventProcessInfoMgntService.selectCboList(parameter.get("ds_search").get(0));
        if(rsCbo.size() > 0 ){
        	parameter.get("ds_search").get(0).put("mclassCd", rsCbo.get(0).get("mclassCd"));
        }
        
        //테마 콤보
        rsTheme = eventProcessInfoMgntService.selectThemeList(parameter.get("ds_search").get(0));

        // 기기콤보
        rsLclass = eventProcessInfoMgntService.selectLclass(parameter.get("ds_search").get(0));
        rsMclass = eventProcessInfoMgntService.selectMclass(parameter.get("ds_search").get(0));
        rsSclass = eventProcessInfoMgntService.selectSclass(parameter.get("ds_search").get(0));

        //신청목록
        rsGrdlist = eventProcessInfoMgntService.selectGrdList(parameter.get("ds_search").get(0));
        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsCboOutput", rsCbo);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsGrdSearchOutput", rsGrdlist);
        super.addOutDataSet(mav, "dsLclassOutput", rsLclass);
        super.addOutDataSet(mav, "dsMclassOutput", rsMclass);
        super.addOutDataSet(mav, "dsSclassOutput", rsSclass);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

     /**
      * 이벤트 Theme 목록을 조회한다.
      *
      * @param xpDto
      *            XplatformMapDTO XPLATFORM에서 전달된 Map
      * @return
      *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
      * @throws Exception
      */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectTheme.xdo")
    public ModelAndView selectTheme(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        //테마 콤보
        RecordSet rsTheme = eventProcessInfoMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsThemeListOutput", rsTheme);


        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     *
     * 이벤트 팝업에서 마스터 정보 및 진행정보 조회
     *
     * @param xpDTO
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("selectMstProgress.xdo")
    public ModelAndView selectMstProgress(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsEventMst     = null;
        RecordSet rsMstProgress  = null;

        // master 정보
        rsEventMst    = eventProcessInfoMgntService.selectEventMst(parameter.get("ds_search").get(0));

        // 진행정보
        rsMstProgress = eventProcessInfoMgntService.selectMstProgress(parameter.get("ds_search").get(0));

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsEventMst", rsEventMst);
        super.addOutDataSet(mav, "dsMstProgress", rsMstProgress);

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

    /**
     * 이벤트 신청 등록관리 목록을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping("selectRequestInfo.xdo")
    public ModelAndView selectRequestInfo(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();

        //조회 조건 파라미터를 얻는다.
        Map <String, Object> inVar = xpDTO.getInVariableMap();

        //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
        Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

        RecordSet rsEventReq  = null;
        RecordSet rsProgress  = null;
        RecordSet rsInforeg   = null;
        RecordSet rsUtensil   = null;
        RecordSet rsTheme     = null;
        List<Map> fileList    = null;

        // 신청정보
        rsEventReq = eventProcessInfoMgntService.selectEventReq(parameter.get("ds_search").get(0));

        // 진행정보
        rsProgress = eventProcessInfoMgntService.selectProgress(parameter.get("ds_search").get(0));

        // 기기정보
        rsInforeg  = eventProcessInfoMgntService.selectInforeg(parameter.get("ds_search").get(0));

        // 사업장 기기정보
        rsUtensil  = eventProcessInfoMgntService.selectUpjangutensil(parameter.get("ds_search").get(0));

        // 테마 콤보
        parameter.get("ds_search").get(0).put("mclassCd", rsEventReq.get(0).get("mclassCd"));
        rsTheme = eventProcessInfoMgntService.selectThemeList(parameter.get("ds_search").get(0));

        //첨부파일 참조일련번호를 얻는다.
        String strRefSeq = "";
        if (rsEventReq.size() > 0) {
            Map map = rsEventReq.get(0);
            if (map.get("fileId") != null)
                strRefSeq =  map.get("fileId").toString(); //필드명이 "refSeq"인 경우임
        }

        //첨부파일 조회 Service 호출
        if(!"".equals(strRefSeq)) {
            fileList = attachFileService.selectList(strRefSeq);
        }

        //개인정보보호 접근로그를 쌓는다. 조회조건과 조회건수
        accessLogService.readLog(inVar, rsEventReq.size());

        //XPlatform으로 넘겨줄 Dataset을 설정한다.
        super.addOutDataSet(mav, "dsEventReq", rsEventReq);
        super.addOutDataSet(mav, "dsProgress", rsProgress);
        super.addOutDataSet(mav, "dsInforeg",  rsInforeg);
        super.addOutDataSet(mav, "dsUtensil",  rsUtensil);
        super.addOutDataSet(mav, "dsThemeOutput", rsTheme);
        super.addOutDataSet(mav, "dsFile", fileList);   //첨부파일 정보

        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
    }

	/**
	 * 첨부파일 목록을 조회한다.
	 * <pre>
	 * - 첨부파일 조회하기 (공통)
	 * </pre>
	 *
	 * @param xpDto
	 *            XplatformMapDTO XPLATFORM에서 전달된 Map
	 * @return
	 *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
	 * @throws Exception
	 */
	@RequestMapping("selectFileList.xdo")
	public ModelAndView selectFileList(
			@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {

		//XPLATFORM에 결과를 전달할 객체 생성
		ModelAndView mav = super.createModelAndView();

		//조회 조건 파라미터를 얻는다.
		Map<String, DataSetMap> param = xpDTO.getInDataSetMap();
		//채용인력Pool관리 을(를) 조회한다.
		
		String strRefSeq =  LimsUtil.checkNull(param.get("ds_search").get(0).get("fileId"));
		
		//첨부파일 조회 Service 호출
		List<Map> fileList = attachFileService.selectList(strRefSeq);
		
		//XPlatform으로 넘겨줄 Dataset을 설정한다.
		super.addOutDataSet(mav, "ds_file", fileList);	//첨부파일 정보
		
		//전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
		return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
	}

    /**
     * 기기/물류 재고수량을 조회한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
     * @throws Exception
     */
   @SuppressWarnings("unchecked")
   @RequestMapping("selectInventoryQty.xdo")
   public ModelAndView selectInventoryQty(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
       //XPLATFORM에 결과를 전달할 객체 생성
       ModelAndView mav = super.createModelAndView();

       //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
       Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

       //기기 수량
       RecordSet rsTheme = eventProcessInfoMgntService.selectInventoryQty(parameter.get("ds_search").get(0));

       //XPlatform으로 넘겨줄 Dataset을 설정한다.
       super.addOutDataSet(mav, "dsInvQty", rsTheme);

       //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
       return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
   }

   /**
    * 코드 정보를 조회한다.
    *
    * @param xpDto
    *            XplatformMapDTO XPLATFORM에서 전달된 Map
    * @return
    *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
    * @throws Exception
    */
   @SuppressWarnings("unchecked")
   @RequestMapping("selectInforegCode.xdo")
   public ModelAndView selectInforegCode(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
       //XPLATFORM에 결과를 전달할 객체 생성
       ModelAndView mav = super.createModelAndView();

       //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
       Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

       //기기 코드를 조회
       RecordSet rsTheme = eventProcessInfoMgntService.selectInforegCode(parameter.get("ds_search").get(0));

       //XPlatform으로 넘겨줄 Dataset을 설정한다.
       super.addOutDataSet(mav, "ds_fsCodeMappop", rsTheme);

       //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
       return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
   }

   /**
    * 서버 사진을 조회한다.
    *
    * @param xpDto
    *            XplatformMapDTO XPLATFORM에서 전달된 Map
    * @return
    *            ModelAndView XPLATFORM에 결과로 전달되는 조회 목록
    * @throws Exception
    */
   @SuppressWarnings("unchecked")
   @RequestMapping("selectImgList.xdo")
   public ModelAndView selectImgList(@Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO) throws Exception {
       //XPLATFORM에 결과를 전달할 객체 생성
       ModelAndView mav = super.createModelAndView();

       //XPlatform에서 넘어온 Dataset Parameter을 추출한다.
       Map<String, DataSetMap> parameter = xpDTO.getInDataSetMap();

       RecordSet rsImgList = eventProcessInfoMgntService.selectImgList(parameter.get("ds_search").get(0));

       //XPlatform으로 넘겨줄 Dataset을 설정한다.
       super.addOutDataSet(mav, "dsImgeSvrList", rsImgList);

       //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
       return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
   }

    /**
     * 이벤트 신청정보 관리(을)를 Insert/Update/Delete 처리한다.
     *
     * @param xpDto
     *            XplatformMapDTO XPLATFORM에서 전달된 Map
     * @return
     *            ModelAndView XPLATFORM에 처리결과를 전달
     * @throws Exception
     */
    @RequestMapping("saveList.xdo")
    public ModelAndView saveList(
            @Bind(id = "", type = XplatformMapDTO.class) XplatformMapDTO xpDTO,	HttpServletRequest req) throws Exception {

        //XPLATFORM에 결과를 전달할 객체 생성
        ModelAndView mav = super.createModelAndView();
        
        //로그인 정보를 반환한다.
      	LoginDTO loginDTO = (LoginDTO) SessionUtil.getLoginSession(req);

        //XPlatform에서 넘어온 Dataset Parameter를 추출한다.
        Map<String, DataSetMap> param = xpDTO.getInDataSetMap();

        //개인정보보호 접근로그를 쌓는다.
        accessLogService.writeLog(messageService.getMessage("accesslog.message.write", new Object[]{"TRSF_ADDR_ENC, CNTC_NUM_ENC"}));

        //이벤트 진행정보 관리을(를) 등록, 수정, 삭제 처리한다.
        int processCnt = eventProcessInfoMgntService.saveList(param.get("ds_form"), param.get("ds_progress"), param.get("ds_inforeg"), param.get("ds_utensil"), param.get("ds_file"), loginDTO.getSabun());
        
        
        if(processCnt != -1){
	        //처리건수를 OutVariable에 설정한다.
	        super.addOutVariable(mav, "fv_processCnt", processCnt);
	        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
	        return super.setResultSet(mav, DefaultConsts.OK_CODE, "");
        }else{
	        //전달할 결과 ResultSet에 설정 : 메시지는 업무에 따라 필요하면 설정
	        return super.setResultSet(mav, DefaultConsts.ERR_CODE, "신청수량이 잔여수량보다 큽니다.");
        }
    }
}
