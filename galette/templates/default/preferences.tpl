{extends file="page.tpl"}
{block name="content"}
        <form action="{path_for name="store-preferences"}" method="post" enctype="multipart/form-data" class="ui form">
        <div class="ui top attached tabular menu tabbed">
            <a class="item active" data-tab="general">{_T string="General"}</a>
            <a class="item" data-tab="social">{_T string="Social networks"}</a>
            <a class="item" data-tab="parameters">{_T string="Parameters"}</a>
            <a class="item" data-tab="mail">{_T string="E-Mail"}</a>
            <a class="item" data-tab="labels">{_T string="Labels"}</a>
            <a class="item" data-tab="cards">{_T string="Cards"}</a>
{if $login->isSuperAdmin()}
            <a class="item" data-tab="admin">{_T string="Admin"}</a>
{/if}
        </div>
        <div class="ui bottom attached tab segment" data-tab="general">
            <div class="ui two column grid">
                <div class="column">
{*
  <div class="column">
    <div class="ui three column grid">
      <div class="column"></div>
      <div class="column"></div>
      <div class="column"></div>
    </div>
  </div>
  <div class="column"></div>
  <div class="column"></div>
  <div class="column">
    <div class="ui grid">
      <div class="ten wide column"></div>
      <div class="six wide column"></div>
    </div>
  </div>
</div>*}
            <div class="{if $required.pref_nom eq 1}required {/if} field">
                <label for="pref_nom">{_T string="Name of the association:"}</label>
                <input{if $required.pref_nom eq 1} required="required"{/if} type="text" name="pref_nom" id="pref_nom" value="{$pref.pref_nom}" maxlength="190"/>
            </div>
            <div class="{if isset($required.pref_slogan) and $required.pref_slogan eq 1}required {/if} field">
                <label for="pref_slogan" class="tooltip">{_T string="Association's short description:"}</label>
                <span class="tip">{_T string="Enter here a short description for your association, it will be displayed on the index page and into pages' title."}</span>
                <input{if isset($required.pref_slogan) and $required.pref_slogan eq 1} required="required"{/if} type="text" name="pref_slogan" id="pref_slogan" value="{$pref.pref_slogan}"/>
            </div>
            <div class="{if isset($required.pref_adresse) and $required.pref_adresse eq 1}required {/if} field">
                <label for="pref_adresse">{_T string="Address:"}</label>
                <input{if isset($required.pref_adresse) and $required.pref_adresse eq 1} required="required"{/if} type="text" name="pref_adresse" id="pref_adresse" value="{$pref.pref_adresse}" maxlength="190"/><br/>
            </div>
            <div class="field">
                <label for="pref_adresse2" class="libelle">{_T string="Address:"} {_T string=" (continuation)"}</label>
                <input type="text" name="pref_adresse2" id="pref_adresse2" value="{$pref.pref_adresse2}" maxlength="190"/>
            </div>
            <div class="{if $required.pref_cp eq 1}required {/if} field">
                <label for="pref_cp">{_T string="Zip Code:"}</label>
                <input{if isset($required.pref_cp) and $required.pref_cp eq 1} required="required"{/if} type="text" name="pref_cp" id="pref_cp" value="{$pref.pref_cp}" maxlength="10"/>
            </div>
            <div class="{if $required.pref_ville eq 1}required {/if} field">
                <label for="pref_ville">{_T string="City:"}</label>
                <input{if isset($required.pref_ville) and $required.pref_ville eq 1} required="required"{/if} type="text" name="pref_ville" id="pref_ville" value="{$pref.pref_ville}" maxlength="100"/>
            </div>
            <div class="{if $required.pref_pays eq 1}required {/if} field">
                <label for="pref_pays">{_T string="Country:"}</label>
                <input{if isset($required.pref_pays) and $required.pref_pays eq 1} required="required"{/if} type="text" name="pref_pays" id="pref_pays" value="{$pref.pref_pays}" maxlength="50"/>
            </div>
            <div class="{if $required.pref_website eq 1}required {/if} field">
                <label for="pref_website">{_T string="Website:"}</label>
                <input{if isset($required.pref_website) and $required.pref_website eq 1} required="required"{/if} type="text" name="pref_website" id="pref_website" value="{$pref.pref_website}" maxlength="100"/>
            </div>
                </div>{* /column *}
                <div class="column">
            <div class="field">
                <label for="logo_picture">{_T string="Logo:"}</label>
{if $logo->isCustom()}
                <img src="{path_for name="logo"}" class="picture" width="{$logo->getOptimalWidth()}" height="{$logo->getOptimalHeight()}" alt="{_T string="Current logo"}"/><br/>
                <label for="del_logo">{_T string="Delete image"}</label><input type="checkbox" name="del_logo" id="del_logo" value="1" /><br />
{/if}
                <input type="file" name="logo" id="logo_picture"{if $GALETTE_MODE eq 'DEMO'} disabled="disabled"{/if}/>
            </div>
            <div class="field">
                <label class="tooltip">{_T string="Postal address:"}</label>
                <span class="tip">{_T string="Use either the address setted below or select a staff member to retrieve he's address."}</span>
                <div class="inline fields">
                    <div class="field">
                        <label for="pref_postal_adress_0">{_T string="from preferences"}</label>
                        <input type="radio" name="pref_postal_adress" id="pref_postal_adress_0" value="{Galette\Core\Preferences::POSTAL_ADDRESS_FROM_PREFS}" {if $pref.pref_postal_adress eq constant('Galette\Core\Preferences::POSTAL_ADDRESS_FROM_PREFS')}checked="checked"{/if}/>
                    </div>
                    <div class="field">
                        <label for="pref_postal_adress_1">{_T string="from a staff user"}</label>
                        <input type="radio" name="pref_postal_adress" id="pref_postal_adress_1" value="{Galette\Core\Preferences::POSTAL_ADDRESS_FROM_STAFF}" {if $pref.pref_postal_adress eq constant('Galette\Core\Preferences::POSTAL_ADDRESS_FROM_STAFF')}checked="checked"{/if}/>
                    </div>
                </div>
                <label for="pref_postal_staff_member">{_T string="Staff member"}</label>
                <select name="pref_postal_staff_member" id="pref_postal_staff_member" class="ui search dropdown">
                    <option value="-1">{_T string="-- Choose a staff member --"}</option>
                {foreach from=$staff_members item=staff}
                    <option value="{$staff->id}"{if $staff->id eq $pref.pref_postal_staff_member} selected="selected"{/if}>{$staff->sname} ({$staff->sstatus})</option>
                {/foreach}
                </select>
            </div>
            <div class="{if $required.pref_footer eq 1}required {/if} field">
                <label for="pref_footer" class="tooltip">{_T string="Footer text:"}</label>
                <span class="tip">{_T string="Enter a text (HTML allowed) that will be displayed in the footer of every page"}</span>
                <textarea{if isset($required.pref_footer) and $required.pref_footer eq 1} required="required"{/if} name="pref_footer" id="pref_footer" rows="2">{$pref.pref_footer}</textarea>
            </div>
            <div class="field">
                <label class="tooltip">{_T string="Telemetry date:"}</label>
                <span class="tip">{_T string="Last telemetry sent date."}</span>
                <span>
                    {if $pref.pref_telemetry_date}
                        {$pref.pref_telemetry_date|date_format:"%a %d/%m/%Y - %R"}
                    {else}
                        {_T string="Never"}
                    {/if}
                    - <a href="#" id="telemetry" class="button"><i class="fas fa-chart-bar" aria-hidden="true"></i> {_T string="send"}</a>
                </span>
            </div>
            <div class="field">
                <label class="tooltip">{_T string="Registration date:"}</label>
                <span class="tip">{_T string="Date on which you registered your Galette instance."}</span>
                <span>
                    {if $pref.pref_registration_date}
                        {assign var="regtxt" value={_T string="Update your informations"}}
                        {$pref.pref_registration_date|date_format:"%a %d/%m/%Y - %R"}
                    {else}
                        {assign var="regtxt" value={_T string="Register"}}
                        {_T string="Not registered"}
                    {/if}
                    - <a href="{$smarty.const.GALETTE_TELEMETRY_URI}reference?showmodal&uuid={$pref.pref_registration_uuid}" id="register" target="_blank" class="button"><i class="fas fa-marker"></i>{$regtxt}</a>
                </span>
            </div>
                </div>{* /column *}
            </div>{* /column grid *}
        </div>{* /tab segment*}
        <div class="ui bottom attached tab segment" data-tab="social">
            <div class="field">
                <label for="pref_googleplus">{_T string="Google+"}</label>
                <input type="text" name="pref_googleplus" id="pref_googleplus" value="{$pref.pref_googleplus}" class="large"/>
            </div>
            <div class="field">
                <label for="pref_facebook">{_T string="Facebook"}</label>
                <input type="text" name="pref_facebook" id="pref_facebook" value="{$pref.pref_facebook}" class="large"/>
            </div>
            <div class="field">
                <label for="pref_twitter">{_T string="Twitter"}</label>
                <input type="text" name="pref_twitter" id="pref_twitter" value="{$pref.pref_twitter}" class="large"/>
            </div>
            <div class="field">
                <label for="pref_linkedin">{_T string="LinkedIn"}</label>
                <input type="text" name="pref_linkedin" id="pref_linkedin" value="{$pref.pref_linkedin}" class="large"/>
            </div>
            <div class="field">
                <label for="pref_viadeo">{_T string="Viadeo"}</label>
                <input type="text" name="pref_viadeo" id="pref_viadeo" value="{$pref.pref_viadeo}" class="large"/>
            </div>
        </div>{* /tab segment*}
        <div class="ui bottom attached tab segment active" data-tab="parameters">
            <div class="ui two column grid">
                <div class="column">
            <div class="field">
                <label for="pref_lang" >{_T string="Default language:"}</label>
                <select name="pref_lang" id="pref_lang" class="lang ui search dropdown">
{foreach item=langue from=$languages}
                    <option value="{$langue->getID()}" {if $pref.pref_lang eq $langue->getID()}selected="selected"{/if}>{$langue->getName()|ucfirst}</option>
{/foreach}
                </select>
            </div>
            {*<div class="field">
                <label for="pref_theme">{_T string="Default theme:"}</label>
                <select name="pref_theme" id="pref_theme" class="ui search dropdown">
{foreach item=theme from=$themes}
                    <option value="{$theme}" {if $pref.pref_theme eq $theme}selected="selected"{/if}>{$theme|ucfirst}</option>
{/foreach}
                </select>
            </div>*}
            <div class="field">
                <label for="pref_numrows">{_T string="Lines / Page:"}</label>
                <select name="pref_numrows" id="pref_numrows" class="ui search dropdown">
                    {html_options options=$pref_numrows_options selected=$pref.pref_numrows}
                </select>
            </div>
            <div class="field">
                <label for="pref_redirect_on_create">{_T string="After member creation:"}</label>
                <select name="pref_redirect_on_create" id="pref_redirect_on_create" class="ui search dropdown">
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_DEFAULT')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_DEFAULT')} selected="selected"{/if}>{_T string="create a new contribution (default action)"}</option>
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_TRANS')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_TRANS')} selected="selected"{/if}>{_T string="create a new transaction"}</option>
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_NEW')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_NEW')} selected="selected"{/if}>{_T string="create another new member"}</option>
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_SHOW')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_SHOW')} selected="selected"{/if}>{_T string="show member"}</option>
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_LIST')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_LIST')} selected="selected"{/if}>{_T string="go to members list"}</option>
                    <option value="{constant('Galette\Entity\Adherent::AFTER_ADD_HOME')}"{if $pref.pref_redirect_on_create  == constant('Galette\Entity\Adherent::AFTER_ADD_HOME')} selected="selected"{/if}>{_T string="go to main page"}</option>
                </select>
            </div>
            <div class="field">
                <label for="pref_log">{_T string="Logging level:"}</label>
                <select name="pref_log" id="pref_log" class="ui search dropdown">
                    <option value="{Galette\Core\Preferences::LOG_DISABLED}" {if $pref.pref_log eq constant('Galette\Core\Preferences::LOG_DISABLED')}selected="selected"{/if}>{_T string="Disabled"}</option>
                    <option value="{Galette\Core\Preferences::LOG_ENABLED}" {if $pref.pref_log eq constant('Galette\Core\Preferences::LOG_ENABLED')}selected="selected"{/if}>{_T string="Enabled"}</option>
                </select>
            </div>
            <div class="field">
                <label for="pref_statut">{_T string="Default membership status:"}</label>
                <select name="pref_statut" id="pref_statut" class="ui search dropdown">
                    {html_options options=$statuts selected=$pref.pref_statut}
                </select>
            </div>
            <div class="field">
                <label for="pref_filter_account">{_T string="Default account filter:"}</label>
                <select name="pref_filter_account" id="pref_filter_account" class="ui search dropdown">
                    {html_options options=$accounts_options selected=$pref.pref_filter_account}
                </select>
            </div>
            <div class="field">
                <label for="pref_membership_ext">{_T string="Default membership extension:"}</label>
                <input type="text" name="pref_membership_ext" id="pref_membership_ext" value="{$pref.pref_membership_ext}" maxlength="2"{if isset($required.pref_membership_ext) and $required.pref_membership_ext eq 1} required="required"{/if}/>
                <span class="exemple">{_T string="(Months)"}</span>
            </div>
            <div class="field">
                <label for="pref_beg_membership">{_T string="Beginning of membership:"}</label>
                <input type="text" name="pref_beg_membership" id="pref_beg_membership" value="{$pref.pref_beg_membership}" maxlength="5"{if isset($required.pref_beg_membership) and $required.pref_beg_membership eq 1} required="required"{/if}/>
                <span class="exemple">{_T string="(dd/mm)"}</span>
            </div>
                </div>{* /column *}
                <div class="column">
            <div class="field inline">
                <label for="pref_bool_publicpages">{_T string="Public pages enabled?"}</label>
                <input type="checkbox" name="pref_bool_publicpages" id="pref_bool_publicpages" value="1" {if $pref.pref_bool_publicpages} checked="checked"{/if}{if isset($required.pref_bool_publicpages) and $required.pref_bool_publicpages eq 1} required="required"{/if}/>
            </div>
            <div class="field" id="publicpages_visibility"{if !$pref.pref_bool_publicpages} class="hidden"{/if}>
                <label for="pref_publicpages_visibility">{_T string="Show public pages for"}</label>
                <select name="pref_publicpages_visibility" id="pref_publicpages_visibility" class="ui search dropdown">
                    <option value="{Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_PUBLIC}"{if $pref.pref_publicpages_visibility eq constant('Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_PUBLIC')} selected="selected"{/if}>{_T string="Everyone"}</option>
                    <option value="{Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_RESTRICTED}"{if $pref.pref_publicpages_visibility eq constant('Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_RESTRICTED')} selected="selected"{/if}>{_T string="Up to date members"}</option>
                    <option value="{Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_PRIVATE}"{if $pref.pref_publicpages_visibility eq constant('Galette\Core\Preferences::PUBLIC_PAGES_VISIBILITY_PRIVATE')} selected="selected"{/if}>{_T string="Admin and staff only"}</option>
                </select>
            </div>
            <div class="field inline">
                <label for="pref_bool_selfsubscribe">{_T string="Self subscription enabled?"}</label>
                <input type="checkbox" name="pref_bool_selfsubscribe" id="pref_bool_selfsubscribe" value="1"{if $pref.pref_bool_selfsubscribe} checked="checked"{/if} {if isset($required.pref_bool_selfsubscribe) and $required.pref_bool_selfsubscribe eq 1} required="required"{/if}/>
            </div>
            <div class="field">
                <label for="pref_new_contrib_script" class="tooltip">{_T string="Post new contribution script URI"}</label>
                <span class="tip">{_T string="Enter a script URI that would be called after adding a new contribution.<br/>Script URI must be prefixed by one of '<em>galette://</em>' for Galette internal call. '<em>file://</em>' for a direct file call, '<em>get://</em>' or '<em>post://</em>' for HTTP calls (prefix will be replaced by http:// in those cases)."}</span>
                <input type="text" name="pref_new_contrib_script" id="pref_new_contrib_script" value="{$pref.pref_new_contrib_script}"{if isset($required.pref_new_contrib_script) and $required.pref_new_contrib_script eq 1} required="required"{/if}/>
            </div>
            <div class="field">
                <label for="pref_rss_url" class="tooltip">{_T string="RSS feed URL"}</label>
                <span class="tip">{_T string="Enter the full URL to the RSS feed. It will be displayed on Galette desktop."}</span>
                <input type="text" name="pref_rss_url" id="pref_rss_url" value="{$pref.pref_rss_url}"{if isset($required.pref_rss_url) and $required.pref_rss_url eq 1} required="required"{/if}/>
            </div>
            <div class="field">
                <label for="pref_galette_url" class="tooltip">{_T string="Galette base URL"}</label>
                <span class="tip">{_T string="Enter the base URL to your Galette instance. You should only change this parameter if the current page URL is not:<br/>%galette_url" pattern="/%galette_url/" replace=$preferences->getDefaultURL()|cat:{path_for name="preferences"}}</span>
                <input type="text" name="pref_galette_url" id="pref_galette_url" placeholder="{$preferences->getDefaultURL()}" value="{$pref.pref_galette_url}"{if isset($required.pref_galette_url) and $required.pref_galette_url eq 1} required="required"{/if}/>
            </div>
            <div class="field inline">
                <label for="pref_show_id" class="tooltip">{_T string="Show identifiers"}</label>
                <span class="tip">{_T string="Display database identifiers in related windows"}</span>
                <input type="checkbox" name="pref_show_id" id="pref_show_id" value="1" {if $pref.pref_show_id} checked="checked"{/if}{if isset($required.pref_show_id) and $required.pref_show_id eq 1} required="required"{/if}/>
            </div>
                </div>{* /column *}
            </div>{* /column grid *}
        </div>{* /tab segment*}
        <div class="ui bottom attached tab segment active" data-tab="mail">
            <div class="ui two column grid">
                <div class="column">
    {if $GALETTE_MODE eq 'DEMO'}
                    <div class="ui negative message">
                        <p>{_T string="Application runs under demo mode. This functionnality is not enabled, sorry."}</p>
                    </div>
    {else}
                <div class="field">
                    <label for="pref_email_nom">{_T string="Sender name:"}</label>
                    <input type="text" name="pref_email_nom" id="pref_email_nom" value="{$pref.pref_email_nom}" maxlength="50"{if isset($required.pref_email_nom) and $required.pref_email_nom eq 1} required="required"{/if}/>
                </div>
                <div class="{if isset($required.pref_email) and $required.pref_email eq 1}required {/if}field">
                    <label for="pref_email">{_T string="Sender Email:"}</label>
        {assign var="pref_email" value=""}
        {foreach from=$preferences->vpref_email item=vmail}
            {if $vmail@first }
                {assign var="pref_email" value=$vmail}
            {else}
                {assign var="pref_email" value=$pref_email|cat:",{$vmail}"}
            {/if}
        {/foreach}
                    <input type="text" name="pref_email" id="pref_email" value="{$pref_email}" maxlength="100" size="30"{if isset($required.pref_email) and $required.pref_email eq 1} required="required"{/if}/>
                    <span class="exemple">{_T string="(You can enter several emails separated with a comma. First address will be the default one.)"}</span>
                </div>
                <div class="field">
                    <label for="pref_email_reply_to" class="tooltip">{_T string="Reply-To Email:"}</label>
                    <span class="tip">{_T string="Leave empty to use Sender Email as reply address"}</span>
                    <input type="text" name="pref_email_reply_to" id="pref_email_reply_to" value="{$pref.pref_email_reply_to}" maxlength="100" size="30"{if isset($required.pref_email_reply_to) and $required.pref_email_reply_to eq 1} required="required"{/if}/>
                </div>
                <div class="field">
        {assign var="pref_email_newadh" value=""}
        {foreach from=$preferences->vpref_email_newadh item=vmail_newadh}
            {if $vmail_newadh@first }
                {assign var="pref_email_newadh" value=$vmail_newadh}
            {else}
                {assign var="pref_email_newadh" value=$pref_email_newadh|cat:",{$vmail_newadh}"}
            {/if}
        {/foreach}

                    <label for="pref_email_newadh" class="tooltip">{_T string="Members administrator's Email:"}</label>
                    <span class="tip">{_T string="Recipient of new online registation and edition emails"}</span>
                    <input type="text" name="pref_email_newadh" id="pref_email_newadh" value="{$pref_email_newadh}" maxlength="100" size="30"{if isset($required.pref_email_newadh) and $required.pref_email_newadh eq 1} required="required"{/if}/>
                    <span class="exemple">{_T string="(You can enter several emails separated with a comma. First address will be the default one.)"}</span>
                </div>
                <div class="field inline">
                    <label for="pref_bool_mailadh" class="tooltip">{_T string="Send email to administrators?"}</label>
                    <span class="tip">{_T string="Sends an email each time a new member registers online or edit his/her account"}</span>
                    <input type="checkbox" name="pref_bool_mailadh" id="pref_bool_mailadh" value="1" {if $pref.pref_bool_mailadh eq 1}checked="checked"{/if}{if isset($required.pref_bool_mailadh) and $required.pref_bool_mailadh eq 1} required="required"{/if}/>
                </div>
                <div class="field inline">
                    <label for="pref_bool_wrap_mails" class="tooltip">{_T string="Wrap text mails?"}</label>
                    <span class="tip">{_T string="Automatically wrap text mails before sending. Make sure to wrap yourself if you disable that. Please note that current editing mailing will not be affected by a change."}</span>
                    <input type="checkbox" name="pref_bool_wrap_mails" id="pref_bool_wrap_mails" value="1" {if $pref.pref_bool_wrap_mails eq 1}checked="checked"{/if}{if isset($required.pref_bool_wrap_mails) and $required.pref_bool_wrap_mails eq 1} required="required"{/if}/>
                </div>
                <div class="field inline">
                    <label for="pref_editor_enabled" class="tooltip">{_T string="Activate HTML editor?"}</label>
                    <span class="tip">{_T string="Should HTML editor be activated on page load ?"}</span>
                    <input type="checkbox" name="pref_editor_enabled" id="pref_editor_enabled" value="1" {if $pref.pref_editor_enabled eq 1}checked="checked"{/if}{if isset($required.pref_editor_enabled) and $required.pref_editor_enabled eq 1} required="required"{/if}/>
                </div>
                </div>{* /column *}
                <div class="column">
                <div class="grouped fields">
                    <label{if isset($required.pref_mail_method) and $required.pref_mail_method eq 1} required="required"{/if}>{_T string="Emailing method:"}</label>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="no" value="{Galette\Core\GaletteMail::METHOD_DISABLED}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_DISABLED')}checked="checked"{/if}/><label for="no">{_T string="Emailing disabled"}</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="php" value="{Galette\Core\GaletteMail::METHOD_PHPMAIL}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_PHPMAIL')}checked="checked"{/if}/><label for="php">{_T string="PHP mail() function"}</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="smtp" value="{Galette\Core\GaletteMail::METHOD_SMTP}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_SMTP')}checked="checked"{/if}/><label for="smtp">{_T string="Using a SMTP server (slower)"}</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="gmail" value="{Galette\Core\GaletteMail::METHOD_GMAIL}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_GMAIL')}checked="checked"{/if}/><label for="gmail">{_T string="Using GMAIL as SMTP server (slower)"}</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="sendmail" value="{Galette\Core\GaletteMail::METHOD_SENDMAIL}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_SENDMAIL')}checked="checked"{/if}/><label for="sendmail">{_T string="Using Sendmail server"}</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox">
                            <input type="radio" name="pref_mail_method" id="qmail" value="{Galette\Core\GaletteMail::METHOD_QMAIL}" {if $pref.pref_mail_method eq constant('Galette\Core\GaletteMail::METHOD_QMAIL')}checked="checked"{/if}/><label for="qmail">{_T string="Using QMAIL server"}</label>
                        </div>
                    </div>


                    <br/>
                    <a
                        href="{path_for name="testEmail"}#mail"
                        id="btnmail"
                        class="button"
                    >
                        <i class="fas fa-rocket" aria-hidden="true"></i>
                        {_T string="Test mail settings"}
                    </a>
                </div>
                <div id="smtp_parameters"{if $pref.pref_mail_method neq constant('Galette\Core\GaletteMail::METHOD_SMTP')} style="display: none;"{/if}>
                    <div class="field">
                        <label for="pref_mail_smtp_host">{_T string="SMTP server:"}</label>
                        <input type="text" name="pref_mail_smtp_host" id="pref_mail_smtp_host" value="{$pref.pref_mail_smtp_host}" maxlength="100" size="30"/{if isset($required.pref_mail_smtp_host) and $required.pref_mail_smtp_host eq 1} required="required"{/if}>
                    </div>
                    <div class="field">
                        <label for="pref_mail_smtp_port">{_T string="SMTP port:"}</label>
                        <input type="text" name="pref_mail_smtp_port" id="pref_mail_smtp_port" value="{$pref.pref_mail_smtp_port}" size="10"{if isset($required.pref_mail_smtp_port) and $required.pref_mail_smtp_port eq 1} required="required"{/if}/>
                    </div>
                    <div class="grouped fields">
                    <div class="field inline">
                        <label for="pref_mail_smtp_auth" class="tooltip">{_T string="Use SMTP authentication?"}</label>
                        <span class="tip">{_T string="Would emailing use any SMTP authentication? You'll have to provide username and password below. For GMail, authentication will always be on."}</span>
                        <input type="checkbox" name="pref_mail_smtp_auth" id="pref_mail_smtp_auth" value="1" {if $pref.pref_mail_smtp_auth eq 1}checked="checked"{/if}{if isset($required.pref_mail_smtp_auth) and $required.pref_mail_smtp_auth eq 1} required="required"{/if}/>
                    </div>
                    <div class="field inline">
                        <label for="pref_mail_smtp_secure" class="tooltip">{_T string="Use TLS for SMTP?"}</label>
                        <span class="tip">{_T string="Do you want to use server's TLS capabilities?<br/>For GMail, this will always be on."}</span>
                        <input type="checkbox" name="pref_mail_smtp_secure" id="pref_mail_smtp_secure" value="1" {if $pref.pref_mail_smtp_secure eq 1}checked="checked"{/if}{if isset($required.pref_mail_smtp_secure) and $required.pref_mail_smtp_secure eq 1} required="required"{/if}/>
                    </div>
                    <div class="field inline">
                        <label for="pref_mail_allow_unsecure" class="tooltip">{_T string="Allow unsecure TLS?"}</label>
                        <span class="tip">{_T string="Do you want to allow 'unsecure' connections? This may be usefull if you server uses a self-signed certificate, and on some other cases."}</span>
                        <input type="checkbox" name="pref_mail_allow_unsecure" id="pref_mail_allow_unsecure" value="1" {if $pref.pref_mail_allow_unsecure eq 1}checked="checked"{/if}{if isset($required.pref_mail_allow_unsecure) and $required.pref_mail_allow_unsecure eq 1} required="required"{/if}/>
                    </div>
                    </div>
                </div>
                <div id="smtp_auth"{if $pref.pref_mail_method neq constant('Galette\Core\GaletteMail::METHOD_SMTP') && $pref.pref_mail_method neq constant('Galette\Core\GaletteMail::METHOD_GMAIL')} style="display: none;"{/if}>
                    <div class="field">
                        <label for="pref_mail_smtp_user">{_T string="SMTP (or GMail) user:"}</label>
                        <input type="text" name="pref_mail_smtp_user" id="pref_mail_smtp_user" value="{$pref.pref_mail_smtp_user}" maxlength="100" size="30"{if isset($required.pref_mail_smtp_user) and $required.pref_mail_smtp_user eq 1} required="required"{/if}/>
                    </div>
                    <div class="field">
                        <label for="pref_mail_smtp_password">{_T string="SMTP (or GMail) password:"}</label>
                        <input type="password" name="pref_mail_smtp_password" id="pref_mail_smtp_password" value="{$pref.pref_mail_smtp_password}" autocomplete="off" maxlength="100" size="30"{if isset($required.pref_mail_smtp_password) and $required.pref_mail_smtp_password eq 1} required="required"{/if}/>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_mail_sign" class="tooltip">{_T string="Mail signature"}</label>
                    <span class="tip">{_T string="The text that will be automatically set as signature for all outgoing emails.<br/>Variables are quoted with braces, are upper case, and will be replaced automatically.<br/>Refer to the doc to know what variables ara available. "}</span>
                    <textarea name="pref_mail_sign" id="pref_mail_sign" rows="5">{$pref.pref_mail_sign}</textarea>
                </div>
    {/if}
                </div>{* /column *}
            </div>{* /column grid *}
        </div>{* /tab segment*}
        <div class="ui bottom attached tab segment active" data-tab="labels">
            <div class="ui two column grid">
                <div class="column">
                <div class="field">
                    <label for="pref_etiq_marges_v">{_T string="Vertical margins:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_marges_v" id="pref_etiq_marges_v" value="{$pref.pref_etiq_marges_v}" maxlength="4"{if isset($required.pref_etiq_marges_v) and $required.pref_etiq_marges_v eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_etiq_marges_h">{_T string="Horizontal margins:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_marges_h" id="pref_etiq_marges_h" value="{$pref.pref_etiq_marges_h}" maxlength="4"{if isset($required.pref_etiq_marges_h) and $required.pref_etiq_marges_h eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_etiq_hspace">{_T string="Horizontal spacing:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_hspace" id="pref_etiq_hspace" value="{$pref.pref_etiq_hspace}" maxlength="4"{if isset($required.pref_etiq_hspace) and $required.pref_etiq_hspace eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_etiq_vspace">{_T string="Vertical spacing:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_vspace" id="pref_etiq_vspace" value="{$pref.pref_etiq_vspace}" maxlength="4"{if isset($required.pref_etiq_vspace) and $required.pref_etiq_vspace eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                </div>{* /column *}
                <div class="column">
                <div class="field">
                    <label for="pref_etiq_hsize">{_T string="Label width:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_hsize" id="pref_etiq_hsize" value="{$pref.pref_etiq_hsize}" maxlength="4"{if isset($required.pref_etiq_hsize) and $required.pref_etiq_hsize eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_etiq_vsize">{_T string="Label height:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_etiq_vsize" id="pref_etiq_vsize" value="{$pref.pref_etiq_vsize}" maxlength="4"{if isset($required.pref_etiq_vsize) and $required.pref_etiq_vsize eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_etiq_cols">{_T string="Number of label columns:"}</label>
                    <input type="number" name="pref_etiq_cols" id="pref_etiq_cols" value="{$pref.pref_etiq_cols}" maxlength="4"{if isset($required.pref_etiq_cols) and $required.pref_etiq_cols eq 1} required="required"{/if}/>
                </div>
                <div class="field">
                    <label for="pref_etiq_rows">{_T string="Number of label lines:"}</label>
                    <input type="number" name="pref_etiq_rows" id="pref_etiq_rows" value="{$pref.pref_etiq_rows}" maxlength="4"{if isset($required.pref_etiq_rows) and $required.pref_etiq_rows eq 1} required="required"{/if}/>
                </div>
                <div class="field">
                    <label for="pref_etiq_corps">{_T string="Font size:"}</label>
                    <input type="number" name="pref_etiq_corps" id="pref_etiq_corps" value="{$pref.pref_etiq_corps}" maxlength="4"{if isset($required.pref_etiq_corps) and $required.pref_etiq_corps eq 1} required="required"{/if}/>
                </div>
                </div>{* /column *}
            </div>{* /column grid *}
        </div>{* /tab segment*}
        <div class="ui bottom attached tab segment active" data-tab="cards">
            <div class="ui message">
                <p>{_T string="Each card is %width mm width and %height mm height. Each page contains %columns columns and %rows rows. Double check margins and spacings ;)" pattern=["/%width/", "/%height/", "/%columns/", "/%rows/"] replace=[\Galette\IO\PdfMembersCards::getWidth(), \Galette\IO\PdfMembersCards::getHeight(), \Galette\IO\PdfMembersCards::getCols(), \Galette\IO\PdfMembersCards::getRows()]}</p>
            </div>
            <div class="ui two column grid">
                <div class="column">
                <div class="field">
                    <label for="pref_card_abrev">{_T string="Short Text (Card Center):"}</label>
                    <input type="text" name="pref_card_abrev" id="pref_card_abrev" value="{$pref.pref_card_abrev}" size="10" maxlength="10"{if isset($required.pref_card_abrev) and $required.pref_card_abrev eq 1} required="required"{/if}/>
                    <span class="exemple">{_T string="(10 characters max)"}</span>
                </div>
                <div class="field">
                    <label for="pref_card_strip">{_T string="Long Text (Bottom Line):"}</label>
                    <input type="text" name="pref_card_strip" id="pref_card_strip" value="{$pref.pref_card_strip}" size="40" maxlength="65"{if isset($required.pref_card_strip) and $required.pref_card_strip eq 1} required="required"{/if}/>
                    <span class="exemple">{_T string="(65 characters max)"}</span>
                </div>
                <div class=field">
                    <label for="pref_card_tcol" class="tooltip">{_T string="Strip Text Color:"}</label>
                    <span class="tip">{_T string="Hexadecimal color notation: #RRGGBB"}</span>
                    <input type="text" name="pref_card_tcol" id="pref_card_tcol" value="{$pref.pref_card_tcol}" size="7" maxlength="7" class="hex"{if isset($required.pref_card_tcol) and $required.pref_card_tcol eq 1} required="required"{/if}/>
                </div>
                <div class="grouped fields">
                    <label class="tooltip">{_T string="Strip Background colors:"}</label>
                    <span class="tip">{_T string="Strip color will change according to member's status"}</span>
                    <div class="field">
                        <label for="pref_card_scol" class="tooltip">{_T string="Active Member Color:"}</label>
                        <span class="tip">{_T string="Hexadecimal color notation: #RRGGBB"}</span>
                        <input type="text" name="pref_card_scol" id="pref_card_scol" value="{$pref.pref_card_scol}" size="7" maxlength="7" class="hex"{if isset($required.pref_card_scol) and $required.pref_card_scol eq 1} required="required"{/if}/>
                    </div>
                    <div class="field">
                        <label for="pref_card_bcol" class="tooltip">{_T string="Board Members Color:"}</label>
                        <span class="tip">{_T string="Hexadecimal color notation: #RRGGBB"}</span>
                        <input type="text" name="pref_card_bcol" id="pref_card_bcol" value="{$pref.pref_card_bcol}" size="7" maxlength="7" class="hex"{if isset($required.pref_card_bcol) and $required.pref_card_bcol eq 1} required="required"{/if}/>
                    </div>
                    <div class="field inline">
                        <label for="pref_card_hcol" class="tooltip">{_T string="Honor Members Color:"}</label>
                        <span class="tip">{_T string="Hexadecimal color notation: #RRGGBB"}</span>
                        <input type="text" name="pref_card_hcol" id="pref_card_hcol" value="{$pref.pref_card_hcol}" size="7" maxlength="7" class="hex"{if isset($required.pref_card_hcol) and $required.pref_card_hcol eq 1} required="required"{/if}/>
                    </div>
                </div>{* /group fields *}
                <div class="field">
                    <label for="card_logo"{if isset($required.card_logo) and $required.card_logo eq 1} required="required"{/if}>{_T string="Logo:"}</label>
{if $print_logo->isCustom()}
                    <img src="{path_for name="printLogo"}" class="picture" width="{$print_logo->getOptimalWidth()}" height="{$print_logo->getOptimalHeight()}" alt="{_T string="Current logo for printing"}"/><br/>
                    <label for="del_card_logo">{_T string="Delete image"}</label><input type="checkbox" name="del_card_logo" id="del_card_logo" value="1" /><br />
{/if}
                    <input type="file" name="card_logo" id="card_logo"{if $GALETTE_MODE eq 'DEMO'} disabled="disabled"{/if}/>
                </div>
                </div>{* /column *}
                <div class="column">
                <div class="field inline">
                    <label for="pref_card_self">{_T string="Allow members to print card ?"}</label>
                    <input type="checkbox" name="pref_card_self" id="pref_card_self" value="1" {if $pref.pref_card_self eq 1}checked="checked"{/if}{if isset($required.pref_bool_display_title) and $required.pref_bool_display_title eq 1} required="required"{/if}/>
                </div>
                <div class="field inline">
                    <label for="pref_bool_display_title" class="tooltip">{_T string="Show title ?"}</label>
                    <span class="tip">{_T string="Show or not title in front of name"}</span>
                    <input type="checkbox" name="pref_bool_display_title" id="pref_bool_display_title" value="1" {if $pref.pref_bool_display_title eq 1}checked="checked"{/if}{if isset($required.pref_bool_display_title) and $required.pref_bool_display_title eq 1} required="required"{/if}/>
                </div>
                <div class="field">
                    <label for="pref_card_address">{_T string="Address type:"}</label>
                    <select name="pref_card_address" id="pref_card_address" class="ui search dropdown">
                        <option value="0" {if $pref.pref_card_address eq 0}selected="selected"{/if}>{_T string="Email"}</option>
                        <option value="1" {if $pref.pref_card_address eq 1}selected="selected"{/if}>{_T string="MSN"}</option>
                        <option value="2" {if $pref.pref_card_address eq 2}selected="selected"{/if}>{_T string="Jabber"}</option>
                        <option value="3" {if $pref.pref_card_address eq 3}selected="selected"{/if}>{_T string="Web Site"}</option>
                        <option value="4" {if $pref.pref_card_address eq 4}selected="selected"{/if}>{_T string="ICQ"}</option>
                        <option value="5" {if $pref.pref_card_address eq 5}selected="selected"{/if}>{_T string="Zip - Town"}</option>
                        <option value="6" {if $pref.pref_card_address eq 6}selected="selected"{/if}>{_T string="Nickname"}</option>
                        <option value="7" {if $pref.pref_card_address eq 7}selected="selected"{/if}>{_T string="Profession"}</option>
                    </select>
                    <span class="exemple">{_T string="(Choose address printed below name)"}</span>
                </div>
                <div class="field">
                    <label for="pref_card_year">{_T string="Year:"}</label>
                    <input type="text" name="pref_card_year" id="pref_card_year" value="{$pref.pref_card_year}" maxlength="9"{if isset($required.pref_card_year) and $required.pref_card_year eq 1} required="required"{/if}/>
                    <span class="exemple">{_T string="(Enter a year or two years with a separator)"}</span>
                </div>
                <div class="field">
                    <label for="pref_card_marges_v">{_T string="Vertical margins:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_card_marges_v" id="pref_card_marges_v" value="{$pref.pref_card_marges_v}" maxlength="4"{if isset($required.pref_card_marges_v) and $required.pref_card_marges_v eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_card_marges_h">{_T string="Horizontal margins:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_card_marges_h" id="pref_card_marges_h" value="{$pref.pref_card_marges_h}" maxlength="4"{if isset($required.pref_card_marges_h) and $required.pref_card_marges_h eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_card_vspace">{_T string="Vertical spacing:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_card_vspace" id="pref_card_vspace" value="{$pref.pref_card_vspace}" maxlength="4"{if isset($required.pref_card_vspace) and $required.pref_card_vspace eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                <div class="field">
                    <label for="pref_card_hspace">{_T string="Horizontal spacing:"}</label>
                    <div class="ui right labeled input">
                        <input type="number" name="pref_card_hspace" id="pref_card_hspace" value="{$pref.pref_card_hspace}" maxlength="4"{if isset($required.pref_card_hspace) and $required.pref_card_hspace eq 1} required="required"{/if}/>
                        <div class="ui basic label">mm</div>
                    </div>
                </div>
                </div>{* /column *}
            </div>{* /column grid *}
        </div>{* /tab segment*}
{if $login->isSuperAdmin()}
        <div class="ui bottom attached tab inverted segment active" data-tab="admin">
    {if $GALETTE_MODE eq 'DEMO'}
                <div class="ui negative message">
                    {_T string="Application runs under demo mode. This functionnality is not enabled, sorry."}
                </div>
    {else}
                <div class="field">
                    <label for="pref_admin_login">{_T string="Username:"}</label>
                    <input type="text" name="pref_admin_login" id="pref_admin_login" value="{$pref.pref_admin_login}" maxlength="20"{if isset($required.pref_admin_login) and $required.pref_admin_login eq 1} required="required"{/if}/>
                </div>
                <div class="field">
                    <label for="pref_admin_pass">{_T string="Password:"}</label>
                    <input type="password" name="pref_admin_pass" id="pref_admin_pass" value="" maxlength="20" autocomplete="off"{if isset($required.pref_admin_pass) and $required.pref_admin_pass eq 1} required="required"{/if}/>
                </div>
                <div class="field">
                    <label for="pref_admin_pass_check">{_T string="Retype password:"}</label>
                    <input type="password" name="pref_admin_pass_check" id="pref_admin_pass_check" value="" maxlength="20"{if isset($required.pref_admin_pass_check) and $required.pref_admin_pass_check eq 1} required="required"{/if}/>
                </div>
    {/if}
        </div>{* /tab segment*}
{/if}
        </div>
        <div class="button-container">
            <input type="hidden" name="valid" value="1"/>
            <input type="hidden" name="pref_theme" value="default"/>
            <input type="hidden" name="pref_telemetry_date" value="{$pref.pref_telemetry_date}"/>
            <input type="hidden" name="pref_instance_uuid" value="{$pref.pref_instance_uuid}"/>
            <input type="hidden" name="pref_registration_date" value="{$pref.pref_registration_date}"/>
            <input type="hidden" name="pref_registration_uuid" value="{$pref.pref_registration_uuid}"/>
            <button type="submit" class="ui labeled icon button action">
                <i class="save icon"></i> {_T string="Save"}
            </button>
        </div>
        <p>{_T string="NB : The mandatory fields are in"} <span class="required">{_T string="red"}</span></p>
        </form>

        {include file="telemetry.tpl" part="dialog"}
{/block}

{block name="javascripts"}
        <script type="text/javascript">

            $(function(){
                $('#no,#php,#sendmail,#qmail').checkbox({
                    onChange: function(){
                        $('#smtp_parameters,#smtp_auth').hide();
                    }
                });

                $('#smtp,#gmail').checkbox({
                    onChange: function() {
                        $('#smtp_parameters,#smtp_auth').show();
                    }

                });

                $('#gmail').checkbox({
                    onChange: function(){
                        $('#smtp_parameters').hide();
                        $('#smtp_auth').show();
                    }
                });


                //for color pickers
                // hex inputs
                $('input.hex')
                    .validHex()
                    .keyup(function() {
                        $(this).validHex();
                    })
                    .click(function(){
                        $(this).addClass('focus');
                        $('#picker').remove();
                        $('div.picker-on').removeClass('picker-on');
                        $(this).after('<div id="picker"></div>').parent().addClass('picker-on');
                        $('#picker').farbtastic(this);
                        return false;
                    })
                    .wrap('<div class="hasPicker"></div>')
                    .applyFarbtastic();

                //general app click cleanup
                $('body').click(function() {
                    $('div.picker-on').removeClass('picker-on');
                    $('#picker').remove();
                    $('input.focus, select.focus').removeClass('focus');
                });

                $('#pref_bool_publicpages').change(function(){
                    $('#publicpages_visibility').toggleClass('hidden');
                });

                $('#btnmail').on('click', function(e) {
                    e.preventDefault();
                    var _this = $(this);
                    var _value = $('#pref_email_newadh').val();
                    $('body').append('<div id="testEmail" title="{_T string="Test mail settings" escape="js"}"><label for="email_adress">{_T string="Enter the email adress" escape="js"}</label><input type="text" name="email_adress" id="email_adress" value="' + _value + '"/></div>');
                    $('#testEmail').dialog({
                        'modal': true,
                        'hide': 'fold',
                        'width': '20em',
                        create: function (event, ui) {
                            if ($(window ).width() < 767) {
                                $(this).dialog('option', {
                                        'width': '95%',
                                        'draggable': false
                                });
                            }
                        },
                        close: function(event, ui) {
                            $('#testEmail').remove();
                        },
                        buttons: {
                            {_T string="Send"}: function() {
                                $.ajax({
                                    url: _this.attr('href'),
                                    type: 'GET',
                                    data: {
                                        adress: $('#email_adress').val()
                                    },
                                    {include file="js_loader.tpl"},
                                    success: function(res) {
                                        console.log(res);
                                        //display message
                                        $.ajax({
                                            url: '{path_for name="ajaxMessages"}',
                                            method: "GET",
                                            success: function (message) {
                                                $('#testEmail').prepend(message);
                                            }
                                        });
                                    },
                                    error: function () {
                                        alert('{_T string="An error occurred sending test email :(" escape="js"}');
                                    }
                                });
                            }
                        }
                    });
                });

            {include file="telemetry.tpl" part="jsdialog"}
            {include file="telemetry.tpl" part="jsregister"}

            });

            //color pickers setup (sets bg color of inputs)
            $.fn.applyFarbtastic = function() {
                return this.each(function() {
                    $('<div/>').farbtastic(this).remove();
                });
            };

            // validation for hex inputs
            $.fn.validHex = function() {

                return this.each(function() {

                    var value = $(this).val();
                    value = value.replace(/[^#a-fA-F0-9]/g, ''); // non [#a-f0-9]
                    if(value.match(/#/g) && value.match(/#/g).length > 1) value = value.replace(/#/g, ''); // ##
                    if(value.indexOf('#') == -1) value = '#'+value; // no #
                    if(value.length > 7) value = value.substr(0,7); // too many chars

                    $(this).val(value);

                });

            };
        </script>
{/block}
