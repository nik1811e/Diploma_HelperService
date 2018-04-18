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
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@WebServlet(urlPatterns = "/resourcehandler")
public class ResourceHandler extends HttpServlet implements Serializable {
    private static final Logger logger = Logger.getLogger(ResourceHandler.class);

    private Session session = null;
    private Transaction transaction = null;
    private String uuidAuth;
    private String uuidSection;
    private String uuidCourse;
    private String errorMessage;

    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        session = HibernateUtil.getSessionFactory().openSession();
        transaction = session.beginTransaction();
        this.uuidAuth = new CookieUtil(req).getUserUuidFromToken();
        this.uuidSection = req.getParameter("uuid_section");
        this.uuidCourse = req.getParameter("uuid_course");
        try {
            boolean result = addResource(prepareAddResource(req.getParameter("name_resource"),
                    req.getParameter("link"), req.getParameter("author"), req.getParameter("desc")));
            if (result) {
                PrintWriter printWriter = resp.getWriter();
                printWriter.println("Resource was created successfully");
            } else {
                PrintWriter printWriter = resp.getWriter();
                printWriter.println(errorMessage);
            }
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());

        }
    }

    private String prepareAddResource(String name, String link, String author, String description) {
        CourseStructureTO courseStructureTOgson = gson.fromJson(CommonUtil.getJsonStructure(session, this.uuidCourse), CourseStructureTO.class);
        List<SectionTO> sections = new ArrayList<>(courseStructureTOgson.getSection());
        List<SectionTO> tempSectionList = new ArrayList<>();
        ResourceTO resourceTO = new ResourceTO();


        List<List<ResourceTO>> list = new ArrayList<>();
        for (SectionTO section : sections) {
            list.add(section.getResource());
        }

        List<ResourceTO> res = new ArrayList<>();
        for (List<ResourceTO> aList : list) {
            for (ResourceTO anAList : aList) {
                if (anAList.getUuidSection().equals(uuidSection)) {
                    res.add(anAList);
                }
            }
        }

        if (isSectionExist(sections, uuidSection)) {

            resourceTO.setName(String.valueOf(name).trim());
            resourceTO.setLink(String.valueOf(link).trim());
            resourceTO.setAuthor(String.valueOf(author).trim());
            resourceTO.setDescriptionResource(String.valueOf(description).trim());
            resourceTO.setUuidAuth(String.valueOf(this.uuidAuth).trim());
            resourceTO.setUuidSection(String.valueOf(this.uuidSection).trim());
            res.add(resourceTO);

            for (SectionTO sect : sections) {
                if (sect.getUuidSection().equals(this.uuidSection)) {
                    sect.setResource(res);
                    tempSectionList.add(sect);
                } else {
                    tempSectionList.add(sect);
                }
            }
            courseStructureTOgson.setSection(tempSectionList);

        } else {
            errorMessage = "Такого раздела нет";
        }

        return gson.toJson(courseStructureTOgson);
    }

    private boolean addResource(String jsonStructure) {
        try {
            session.createQuery("UPDATE " + VariablesUtil.ENTITY_COURSE + " c SET c.structure = :newStructure WHERE c.uuid = :uuid")
                    .setParameter("newStructure", jsonStructure).setParameter("uuid", this.uuidCourse).executeUpdate();
            transaction.commit();
            return true;
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());
            return false;
        }
    }

    private boolean idUniqueResource(String name, String link) {
        return true;
    }

    private boolean isSectionExist(List<SectionTO> section, String uuid) {
        for (SectionTO sect : section) {
            if (sect.getUuidSection().equals(uuid))
                return true;
        }
        return false;
    }

}
