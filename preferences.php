<?
/* preferences.php
 * - Preferences Galette
 * Copyright (c) 2004 Fr�d�ric Jaqcuot
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 */

	include("includes/config.inc.php");
	include(WEB_ROOT."includes/database.inc.php");
	include(WEB_ROOT."includes/session.inc.php");
	include(WEB_ROOT."includes/functions.inc.php");
  include(WEB_ROOT."includes/i18n.inc.php");
	include(WEB_ROOT."includes/smarty.inc.php");

	if ($_SESSION["logged_status"]==0)
		header("location: index.php");
	if ($_SESSION["admin_status"]==0)
		header("location: voir_adherent.php");

	// initialize warnings
	$error_detected = array();
	$warning_detected = array();
	$confirm_detected = array();

	// flagging required fields
	$required = array(
			'pref_nom' => 1,
			'pref_lang' => 1,
			'pref_numrows' => 1,
			'pref_log' => 1,
			'pref_etiq_marges' => 1,
			'pref_etiq_hspace' => 1,
			'pref_etiq_vspace' => 1,
			'pref_etiq_hsize' => 1,
			'pref_etiq_vsize' => 1,
			'pref_etiq_cols' => 1,
			'pref_etiq_rows' => 1,
			'pref_etiq_corps' => 1,
			'pref_admin_login' => 1,
			'pref_admin_pass' => 1);

	// Validation
	if (isset($_POST['valid']) && $_POST['valid'] == "1")
	{
    // verification de champs
		$insert_values = array();

		// obtain fields
		$requete = "SELECT nom_pref
			    FROM ".PREFIX_DB."preferences";
		$result=$DB->Execute($requete);
		while (!$result->EOF)
		{
			$fieldname = $result->fields['nom_pref'];

			if (isset($_POST[$fieldname]))
				$value=trim($_POST[$fieldname]);
			else
				$value="";

			// fill up pref structure
			$pref[$fieldname] = htmlentities(stripslashes($value),ENT_QUOTES);

			// now, check validity
			if ($value != '')
			switch ($fieldname)
			{
				case 'pref_email':
					if (!is_valid_email($value))
					        $error_detected[] = _T("- Non-valid E-Mail address!");
					break;
				case 'pref_admin_login':
					if (strlen($value)<4)
						$error_detected[] = _T("- The username must be composed of at least 4 characters!");
					else
					{
						//check if login is already taken
						$requete2 = "SELECT id_adh
								FROM ".PREFIX_DB."adherents
								WHERE login_adh=". $DB->qstr($value, get_magic_quotes_gpc());
						$result2 = &$DB->Execute($requete2);
						if (!$result2->EOF)
							$error_detected[] = _T("- This username is already used by another member !");
					}
					break;
				case 'pref_numrows':
					if (!is_numeric($value) || $value <0)
						$error_detected[] = "<LI>"._T("- The numbers and measures have to be integers!")."</LI>";
					break;
				case 'pref_etiq_marges':
				case 'pref_etiq_hspace':
				case 'pref_etiq_vspace':
				case 'pref_etiq_hsize':
				case 'pref_etiq_vsize':
				case 'pref_etiq_cols':
				case 'pref_etiq_rows':
				case 'pref_etiq_corps':
					// prevent division by zero
					if ($fieldname=='pref_numrows' && $value=='0')
						$value = '1';
					if (!is_numeric($value) || $value <0)
						$error_detected[] = "<LI>"._T("- The numbers and measures have to be integers!")."</LI>";
					break;
				case 'pref_admin_pass':
					if (strlen($value)<4)
						$error_detected[] = _T("- The password must be of at least 4 characters!");
					break;
				case 'pref_membership_ext':
					if (!is_numeric($value) || $value < 0)
						$error_detected[] = _T("- Invalid number of months of membership extension.");
					break;
				case 'pref_beg_membership':
					$beg_membership = split("/",$value);
					if (count($beg_membership) != 2)
						$error_detected[] = _T("- Invalid format of beginning of membership.");
					else {
						$now = getdate();
						if (!checkdate($beg_membership[1], $beg_membership[0], $now['year']))
							$error_detected[] = _T("- Invalid date for beginning of	membership.");
					}
					break;
			}
			$insert_values[$fieldname] = $value;
			$result->MoveNext();
		}
		$result->Close();

		// missing relations
		if (isset($insert_values['pref_mail_method']))
		{
			if ($insert_values['pref_mail_method']==2 || $insert_values['pref_mail_method']==1)
			{
				if ($insert_values['pref_mail_method']==2)
				{
					if (!isset($insert_values['pref_mail_smtp']) || $insert_values['pref_mail_smtp']=='')
						$error_detected[] = _T("- You must indicate the SMTP server you wan't to use!");
				}
				if (!isset($insert_values['pref_email_nom']) || $insert_values['pref_email_nom']=='')
					$error_detected[] = _T("- You must indicate a sender name for emails!");
				if (!isset($insert_values['pref_email']) || $insert_values['pref_email']=='')
					$error_detected[] = _T("- You must indicate an email address Galette should use to send emails!");
			}
		}

		if (isset($insert_values['pref_beg_membership']) && $insert_values['pref_beg_membership'] != '' &&
		    isset($insert_values['pref_membership_ext']) && $insert_values['pref_membership_ext'] != '')
		{
			$error_detected[] = _T("- Default membership extention and beginning of membership are mutually exclusive.");
		}

		// missing required fields?
		while (list($key,$val) = each($required))
		{
			if (!isset($pref[$key]))
				$error_detected[] = _T("- Mandatory field empty.")." ".$key;
			elseif (isset($pref[$key]))
				if (trim($pref[$key])=='')
					$error_detected[] = _T("- Mandatory field empty.")." ".$key;
		}

		if (count($error_detected)==0)
		{
			// empty preferences
			$requete = "DELETE FROM ".PREFIX_DB."preferences";
			$DB->Execute($requete);

			// insert new preferences
			while (list($champ,$valeur)=each($insert_values))
			{
				$valeur = stripslashes($valeur);
				$requete = "INSERT INTO ".PREFIX_DB."preferences
					    (nom_pref, val_pref)
					    VALUES (".$DB->qstr($champ).",".$DB->qstr($valeur).");";
				$DB->Execute($requete);
			}

			// picture upload
			if (isset($_FILES['logo']) )
			{
				/*
					TODO :  check filetype
						check filesize
						check filetype
						check file dimensions
						resize picture if gd available
				*/


			  if ($_FILES['logo']['tmp_name'] !='' )
				if (is_uploaded_file($_FILES['logo']['tmp_name']))
				{
					switch (strtolower(substr($_FILES['logo']['name'],-4)))
					{
						case '.jpg':
							$format = 'jpg';
							break;
						case '.gif':
							$format = 'gif';
							break;
						case '.png':
							$format = 'png';
							break;
						default:
							$error_detected[] = _T("- Only .jpg, .gif and .png files are allowed.");
					}

					if (count($error_detected)==0)
					{
						$sql = "DELETE FROM ".PREFIX_DB."pictures
							WHERE id_adh=-1";
						$DB->Execute($sql);

						move_uploaded_file($_FILES['logo']['tmp_name'],WEB_ROOT.'photos/-1'.'.'.$format);

						$f = fopen(WEB_ROOT.'photos/-1'.'.'.$format,"r");
						$picture = '';
						while ($r=fread($f,8192))
							$picture .= $r;
						fclose($f);

						$sql = "INSERT INTO ".PREFIX_DB."pictures
							(id_adh, picture, format, width, height)
							VALUES (-1,'  ',".$DB->Qstr($format).",'1','1')";
						if ( ! $DB->Execute($sql) )
              $error_detected[] = _T("Insert failed");
						if ( ! $DB->UpdateBlob(PREFIX_DB.'pictures','picture',$picture,'id_adh=-1') )
              $error_detected[] = _T("Update Blob failed");
					}
				}
        if ( isset($_POST['del_logo']) && $_POST['del_logo'] == 1 )
        {
          $sql = "DELETE FROM ".PREFIX_DB."pictures
            WHERE id_adh=-1";
          if ( ! $DB->Execute($sql) )
            $error_detected[] = _T("Delete failed");
          if (file_exists(WEB_ROOT.'photos/-1'.'.jpg'))
            unlink (WEB_ROOT.'photos/-1'.'.jpg');
          elseif (file_exists(WEB_ROOT.'photos/-1'.'.png'))
            unlink (WEB_ROOT.'photos/-1'.'.png');
          elseif (file_exists(WEB_ROOT.'photos/-1'.'.gif'))
            unlink (WEB_ROOT.'photos/-1'.'.gif');
        }
			}
		}
	}
	else
	{
		// collect data
		$requete = "SELECT *
			    FROM ".PREFIX_DB."preferences";
		$result = &$DB->Execute($requete);
	  if ($result->EOF)
	    header("location: index.php");
		else
		{
			while (!$result->EOF)
			{
				$pref[$result->fields['nom_pref']] = htmlentities(stripslashes(addslashes($result->fields['val_pref'])), ENT_QUOTES);
				$result->MoveNext();
			}
		}
		$result->Close();
	}

	// logo available ?
		$sql =  "SELECT id_adh ".
			"FROM ".PREFIX_DB."pictures ".
			"WHERE id_adh=-1";
		$result = &$DB->Execute($sql);
		if ($result->RecordCount()!=0)
			$pref["has_logo"]=1;
		else
			$pref["has_logo"]=0;

	$tpl->assign("pref",$pref);
	$tpl->assign('pref_numrows_options', array(
		10 => "10",
		20 => "20",
		50 => "50",
		100 => "100",
		0 => _T("All")));

	$tpl->assign("required",$required);
	$tpl->assign("languages",drapeaux());
	$tpl->assign("error_detected",$error_detected);
	$tpl->assign("warning_detected",$warning_detected);

	// page generation
	$content = $tpl->fetch("preferences.tpl");
	$tpl->assign("content",$content);
	$tpl->display("page.tpl");
?>
