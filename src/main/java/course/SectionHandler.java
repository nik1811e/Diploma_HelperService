package course;

import com.google.gson.Gson;
import course.to.CourseStructureTO;
import course.to.ResourceTO;
import course.to.SectionTO;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(urlPatterns = "/sectionhandler")
public class SectionHandler extends HttpServlet implements Serializable {
    private static final Logger logger = Logger.getLogger(SectionHandler.class);
    private Session session = null;
    private Transaction transaction = null;
    private String uuidCourse;
    private String errorMessage;
    private Gson gson = new Gson();
    private String uuidNewSection = null;


    public SectionHandler() {
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        session = HibernateUtil.getSessionFactory().openSession();
        transaction = session.beginTransaction();
        String uuidAuth = new CookieUtil(req).getUserUuidFromToken();
        this.uuidCourse = String.valueOf(req.getParameter("uuidCourse").trim());
        try {
            boolean result = addSection(prepareAddSection(String.valueOf(req.getParameter("name").trim()),
                    uuidCourse, String.valueOf(req.getParameter("description").trim())));
            if (result) {
                resp.sendRedirect("/pages/section.jsp?uuidSection=" + uuidNewSection);
            }
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());
        }
    }

    private String prepareAddSection(String name, String uuidCourse, String desc) {
        CourseStructureTO courseStructureTOgson = gson.fromJson(CommonUtil.getJsonStructure(session, uuidCourse), CourseStructureTO.class);
        List<SectionTO> sections = new ArrayList<>(courseStructureTOgson.getSection());
        List<ResourceTO> resources = new ArrayList<>();
        SectionTO sectionTO = new SectionTO();
        if (isUniqueSectionName(uuidCourse, name)) {
            uuidNewSection = UUID.randomUUID().toString();
            sectionTO.setName(name);
            sectionTO.setUuidCourse(uuidCourse);
            sectionTO.setDescriptionSection(desc);
            sectionTO.setUuidSection(uuidNewSection);
            sectionTO.setDateLastUpdate(new SimpleDateFormat(VariablesUtil.PATTERN_DATE).format(new Date().getTime()));
            sectionTO.setResource(resources);

            sections.add(sectionTO);
            courseStructureTOgson.setSection(sections);
        }
        return gson.toJson(courseStructureTOgson);
    }

    private boolean isUniqueSectionName(String uuidCourse, String nameSection) {
        List<SectionTO> sectionTOList = new SectionInformation().getCourseSection(uuidCourse);
        for (SectionTO sn :
                sectionTOList) {
            if (sn.getName().equals(nameSection)) {
                return false;
            }
        }
        return true;
    }

    @Transactional
    private boolean addSection(String jsonStructure) {
        try {
            session.createQuery("UPDATE " + VariablesUtil.ENTITY_COURSE + " c SET c.structure = :newStructure WHERE c.uuid = :uuid")
                    .setParameter("newStructure", jsonStructure).setParameter("uuid", this.uuidCourse).executeUpdate();
            transaction.commit();
            return true;
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());
            return false;
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

}
