package com.hwfs.guide.sample.web;

import hone.core.util.record.RecordSet;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hwfs.cmn.crypto.aria.ARIACryptoServiceImpl;
import com.hwfs.cmn.idgen.SequenceIdGenService;
import com.hwfs.cmn.idgen.UUIdGenService;
import com.hwfs.cmn.jms.MessageReader;
import com.hwfs.cmn.jms.MessageWriter;
import com.hwfs.cmn.service.ComCacheService;
import com.hwfs.cmn.service.PropertiesService;
import com.hwfs.cmn.token.ValidationToken;
import com.hwfs.cmn.util.CryptoUtil;
import com.hwfs.sc.cmn.dto.FaxDTO;
import com.hwfs.sc.cmn.dto.SmsDTO;
import com.hwfs.sc.cmn.rmi.RmiClient;
import com.hwfs.sc.cmn.service.FaxService;
import com.hwfs.sc.cmn.service.SmsSendService;

@Controller
public class TestFuncController {

	/** LogService */
	private final Logger logger = LoggerFactory.getLogger (this.getClass());

	/** propertiesService */
	//@Resource(name = "propertiesService")
    @Autowired
	protected PropertiesService propertiesService;
	
	/** messageService */
    @Autowired
    private MessageSourceAccessor messageService;

//	/** accessLogService */
//    @Resource(name = "accessLogService")
//    private AccessLogService accessLogService;

    /** CryptoService */
    @Resource(name = "ariaCryptoService")
    protected ARIACryptoServiceImpl cryptoService;

    /** UUIdGenService */
    @Resource(name = "idGenUUIdService")
    protected UUIdGenService idGenUUIdService;

    /** SequenceIdGenService */
    @Resource(name = "idGenSequenceTest")
    protected SequenceIdGenService idGenSequenceTest;

	@Autowired
	private ComCacheService cacheService;

    /** JMS Read Service */
    @Autowired
    protected MessageReader messageReader;

    /** JMS Write Service */
    @Autowired
    protected MessageWriter messageWriter;

    /** RMI Service Client */
    @Resource(name = "rmiClient")
    protected RmiClient rmiClient;

	/** SmsSendService Bean 생성 */
	@Resource(name = "/sc/cmn/smsSendService")
	private SmsSendService smsSendService;

	/** FaxService Bean 생성 */
	@Resource(name = "/sc/cmn/faxService")
	private FaxService faxService;
	

    /**
     * /guide/sample/TestFunc.jsp 테스트 페이지 호출
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testFunc.do")
    public String testFunc() throws Exception {
    	logger.debug("****************TestFunc{}{}{}",1,2,3);
    	//System.out.println ("*****************************lll");
        return "/guide/test/TestFunc";
    } 

    /**
     * Properties 테스트
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testProperties.do")
    public ModelAndView testProperties() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();
    	bufResult.append(String.format("Properties_Test******************global.fileupload.path=%s", propertiesService.getString("global.fileupload.path")));
    	bufResult.append(String.format("<br>Properties_Test******************autologin.userId=%s", propertiesService.getString("autologin.userId")));
    	
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	
    	mav.setViewName("/guide/test/TestFunc");
        return mav;
    } 

    /**
     * Message Locale 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testLocale.do")
    public ModelAndView testLocale() throws Exception {
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	String[] params = {"aaa", "bbb"}; // 메세지에 넘길 parameter
    	//개발표준은 Locale을 파라미터로 전달하지 않는 것임 : messageService.getMessage("message.test03", params);
    	bufResult.append(String.format("Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params, Locale.KOREAN))); //비표준방식
    	bufResult.append(String.format("<br>Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params)));			//표준방식
    	bufResult.append(String.format("<br>Locale Test******************Locale=%s, message=%s", Locale.getDefault(), messageService.getMessage("message.test03", params, Locale.US)));	//비표준방식
    	
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	mav.setViewName("/guide/test/TestFunc");
    	
    	//test logger
    	try {
    		int i=10/0;
    	}catch(Exception e){
    		logger.error("error", e);
    	}
        return mav;
    }
    
    /**
     * 데이터 암복호 처리기능 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testEncDec.do")
    public ModelAndView testEncDec() throws Exception {
    	String[] testString = { "This is a testing...\nHello!",
    							"한글 테스트입니다...",
    							"!@#$%^&*()_+|~{}:\"<>?-=\\`[];',./" };
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	try {
			//SHA-256 단방향 암호화와 Hash
	    	bufResult.append("단방향*******1234abcd=" + CryptoUtil.encryptPassword("1234abcd") +"\n");
	    	bufResult.append("HASH  *******1234abcd=" + CryptoUtil.getHash("1234abcd") +"\n");
			
	    	//ARIA Crypto Service
	    	for (String str : testString) {
				byte[] encrypted = cryptoService.encrypt(str.getBytes("UTF-8"));
				byte[] decrypted = cryptoService.decrypt(encrypted);
				String strTmp = String.format("원본=%s, 암호화=%s, 복호화=%s\n", str, encrypted.toString(), new String(decrypted, "UTF-8"));
				logger.debug (strTmp);
				bufResult.append(String.format("양방향*******%s",strTmp));
			}

		} catch (Exception e) {
			logger.error(e.getMessage());
			bufResult.append("Error*******");
			bufResult.append(e.getMessage());
		}
    	logger.debug(bufResult.toString());
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	mav.setViewName("/guide/test/TestFunc");
    	return mav;
    } 

    /**
     * 파일 암복호 처리기능 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testEncDecFile.do")
    public String testEncDecFile() throws Exception {

//    	String filePath = propertiesService.getString("global.fileupload.path"); //"/META-INF/spring/file/test.txt";
//    	File fileSrc = new File(filePath + "/" + "test.txt"); //this.getClass().getResource(filePath).getFile());
//    	File fileEncrypted = new File(filePath + "/" + "test.txt.encrypted");
//    	File fileDecrypted = new File(filePath + "/" + "test-decrypted.txt");
		String orgFileName = "D:/test/AA작업목록.xlsx";
		String encFileName = "D:/test/AA작업목록-enc.xlsx";
		String decFileName = "D:/test/AA작업목록-dec.xlsx";

    	try {
    		//기본 서비스 이용
    		cryptoService.encryptFile(orgFileName, encFileName);
    		cryptoService.decryptFile(encFileName, decFileName);
     	} catch (Exception e) {
    		logger.error(e.getMessage());
    	}
    	return "/guide/test/TestFunc";
    }

    /**
     * UUID 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testUUID.do")
    public ModelAndView testUUID() throws Exception {
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("Sequence UUID=" + idGenSequenceTest.getNextStringId() + "<br>");
    	bufResult.append("Random   UUID=" + idGenUUIdService.getNextStringId() + "<br>");
    	bufResult.append("Host     UUID=" + idGenUUIdService.getNextStringHostId() + "<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * Cache 테스트
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testCache.do")
    public ModelAndView testCache() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	//Cache 테스트용
    	String cacheId = "TEST-AA";
    	String cacheVal;
    	if(cacheService.contains(cacheId)) {
    		cacheVal = (String) cacheService.get(cacheId, String.class);
    	}
    	else {
    		cacheVal = "TEST_AA Value";
    		cacheService.put(cacheId, cacheVal);
    	}
    	
    	bufResult.append(String.format("Cache_Test******************%s=%s", cacheId, cacheVal));
    	mav.addObject("resultMsg", bufResult.toString().replace("\n", ""));
    	
    	mav.setViewName("/guide/test/TestFunc");
        return mav;
    } 

    /**
     * JMS Read/Write Blocking방식 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testJmsBlocking.do")
    public ModelAndView testJmsBlocking() throws Exception {
    	
    	String writeMsg = "테스트메시지...abce!@#$%1234";
    	messageWriter.writeMessage(writeMsg);
    	String readMsg = (String)messageReader.readMessage();
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("write message=" + writeMsg + "<br>");
    	bufResult.append("read  message=" + readMsg + "<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * JMS Read/Write NonBlocking방식 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testJmsNonBlocking.do")
    public ModelAndView testJmsNonBlocking() throws Exception {
    	
    	String writeMsg = "NonBlocking 테스트메시지...abce!@#$%1234";
    	messageWriter.writeMessage(writeMsg);
    	
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("write message=" + writeMsg + "<br>");
    	bufResult.append("메시지수신은 이벤트에 의해 서버에서 처리됩니다.<br>");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * CSRF Test
     *
     * @return
     * @throws Exception
     */
    @ValidationToken
    @RequestMapping(value="/guide/test/testCSRF.do")
    public ModelAndView testCSRF() throws Exception {
    	ModelAndView mav = new ModelAndView ();
    	StringBuffer bufResult = new StringBuffer();

    	bufResult.append("CSRF Test OK...");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * AccessLog Test
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testAccessLog.do")
    public ModelAndView testAccessLog() throws Exception {
    	ModelAndView mav = new ModelAndView ();

    	//accessLogService.logTest();
    	//accessLogService.readLog("a=b",10);

    	StringBuffer bufResult = new StringBuffer();
    	bufResult.append("AccessLog Test OK...--> SCC_ACES_LOG테이블 확인");
    	
    	mav.addObject("resultMsg", bufResult.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    }

    /**
     * RMI를 이용하여 서버가 살아 있는지 체크 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testRmiIsAliveServer.do")
    public ModelAndView testRmiIsAliveServer() throws Exception {
    	logger.debug("****************testRmiIsAliveServer");
    	//rmiServiceClient.setServiceUrl(serviceUrl);
    	
    	boolean isAlive = rmiClient.isAliveServer();
    	logger.debug("****************testRmiIsAliveServer result : {}", isAlive);

    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", isAlive);
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 

    /**
     * SMS 전송 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testSms.do")
    public ModelAndView testSms() throws Exception {
    	
		SmsDTO smsDTO = new SmsDTO();
		smsDTO.setTrPhone("01086539182");			//수신자 전화번호
		smsDTO.setTrMsg("SMS 운영 전송 테스트!");	//전송 메시지
		
		//송신자번호가 없는 경우는 기본 전화번호로 설정한다. (업무에 따라 설정)
		smsDTO.setTrCallback(propertiesService.getString("ems.sms.callback.no", ""));
		
		//전송할 시간 : 즉시
		
		smsDTO.setTrCcId(propertiesService.getString("ems.sms.cmn.send.deptId", "")); 			//공통 업부무서
		smsDTO.setTrUserId(propertiesService.getString("ems.sms.cmn.send.defaultSabun", ""));	//디폴트 사용자
		smsDTO.setTrCustNo("");				//업무에서는 수신자의 사업장코드로 설정한다.
		
		logger.info("SMS 전송 Test={}", smsDTO.toString());
		smsSendService.saveSms(smsDTO);
		
    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", smsDTO.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 

    /**
     * FAX 전송 테스트
     *
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/guide/test/testFax.do")
    public ModelAndView testFax() throws Exception {
    	
		//FAX 정보설정
		FaxDTO faxDTO = new FaxDTO();
		faxDTO.setRecipient("홍길동");
		faxDTO.setFaxno("0222860898");
		faxDTO.setFilename(propertiesService.getString("global.filerepository.path") + "/" + "faxtest.pdf");
		
		//등록된 사용자 설정
		faxDTO.setUserid(propertiesService.getString("fax.userid"));	
		faxDTO.setUserpw(propertiesService.getString("fax.userpw"));
		
		//FAX 전송을(를) 등록 처리한다.
		int processCnt = faxService.send(faxDTO);

		logger.info("FAX 전송 Test={}", faxDTO.toString());
		
    	ModelAndView mav = new ModelAndView ();
    	mav.addObject("resultMsg", processCnt + "건 전송 : " + faxDTO.toString());
    	mav.setViewName("/guide/test/TestFunc");
    	
        return mav;
    } 
}
