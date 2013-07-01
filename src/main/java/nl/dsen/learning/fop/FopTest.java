package nl.dsen.learning.fop;

import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

public class FopTest {

    static FopFactory fopFactory = FopFactory.newInstance();
    final OutputStream out;

    public FopTest() throws Exception {
        File file = new File("build/out.png");
        file.createNewFile();
        out = new BufferedOutputStream(new FileOutputStream(file));
    }

    public static void main(String[] args) throws Exception {
        FopTest fopTest = new FopTest();
        fopTest.run();
    }

    private void run() throws Exception {
        try{
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PNG, out);

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();

            Source source = new StreamSource(new File("src/main/resources/in.xml"));
            Result target = new SAXResult(fop.getDefaultHandler());

            transformer.transform(source, target);
        } finally {
            out.close();
        }
    }
}
