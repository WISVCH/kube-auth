package ch.wisvch.kubeauth;

import org.mitre.oauth2.model.RegisteredClient;
import org.mitre.openid.connect.model.OIDCAuthenticationToken;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.text.ParseException;

@Controller
@Secured("ROLE_USER")
public class KubeAuthController {
    private RegisteredClient registeredClient;

    public KubeAuthController(RegisteredClient registeredClient) {
        this.registeredClient = registeredClient;
    }

    @GetMapping("/")
    public String index(Model model, OIDCAuthenticationToken auth) throws ParseException {
        // TODO: determine default namespace for usability
        // TODO: return set of commands in addition to kubeconfig file
        model.addAttribute("client_id", registeredClient.getClientId());
        model.addAttribute("client_secret", registeredClient.getClientSecret());
        model.addAttribute("issuer", auth.getIssuer());
        model.addAttribute("refresh_token", auth.getRefreshTokenValue());

        return "index";
    }
}
