<?php
//============================================================+
// File name   : tce_config.php
// Begin       : 2001-10-23
// Last Update : 2010-09-26
//
// Description : Configuration file for public section.
//
//
// Author: Nicola Asuni
//
// (c) Copyright:
//               Nicola Asuni
//               Tecnick.com S.r.l.
//               Via della Pace, 11
//               09044 Quartucciu (CA)
//               ITALY
//               www.tecnick.com
//               info@tecnick.com
//
// License:
//    Copyright (C) 2004-2010  Nicola Asuni - Tecnick.com S.r.l.
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU Affero General Public License as
//    published by the Free Software Foundation, either version 3 of the
//    License, or (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU Affero General Public License for more details.
//
//    You should have received a copy of the GNU Affero General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//    Additionally, you can't remove, move or hide the original TCExam logo,
//    copyrights statements and links to Tecnick.com and TCExam websites.
//
//    See LICENSE.TXT file for more information.
//============================================================+

/**
 * @file
 * Configuration file for public section.
 * @package com.tecnick.tcexam.public.cfg
 * @brief TCExam Configuration for Public Area
 * @author Nicola Asuni
 * @since 2001-10-23
 */

/**
 */

// --- INCLUDE FILES -----------------------------------------------------------

require_once('../config/tce_auth.php');
require_once('../../shared/config/tce_config.php');

// --- DEFAULT META TAGS -------------------------------------------------------

/**
 * Default site name.
 */
define ('K_SITE_TITLE', 'TCExam');

/**
 * Default site description.
 */
define ('K_SITE_DESCRIPTION', 'TCExam by Tecnick.com');

/**
 * Default site author.
 */
define ('K_SITE_AUTHOR', 'Nicola Asuni - Tecnick.com s.r.l.');

/**
 * Default html reply-to meta tag.
 */
define ('K_SITE_REPLY', ''); //

/**
 * Default keywords.
 */
define ('K_SITE_KEYWORDS', 'TCExam, eExam, e-exam, web, exam');

/**
 * Path to default html icon.
 */
define ('K_SITE_ICON', '../../favicon.ico');

/**
 * Path to public CSS stylesheet.
 */
define ('K_SITE_STYLE', K_PATH_STYLE_SHEETS.'default');

/**
 * Full path to CSS stylesheet for RTL languages.
 */
define ('K_SITE_STYLE_RTL', K_PATH_STYLE_SHEETS.'default_rtl');

// --- OPTIONS / COSTANTS ------------------------------------------------------

/**
 * Max number of rows to display in tables.
 */
define ('K_MAX_ROWS_PER_PAGE', 50);

/**
 * Max file size to be uploaded [bytes].
 */
define ('K_MAX_UPLOAD_SIZE', 1000000);

/**
 * Max memory limit for a PHP script.
 */
define ('K_MAX_MEMORY_LIMIT', '32M');

/**
 * Main page (homepage).
 */
define ('K_MAIN_PAGE', 'index.php');

/**
 * Enable PDF results on public area.
 */
define ('K_ENABLE_PUBLIC_PDF', true);

/**
 * If true hide the expired tests from index table.
 */
define ('K_HIDE_EXPIRED_TESTS', false);

// --- INCLUDE FILES -----------------------------------------------------------

require_once('../../shared/config/tce_db_config.php');
require_once('../../shared/code/tce_db_connect.php');
require_once('../../shared/code/tce_functions_general.php');

// --- PHP SETTINGS ------------------------------------------------------------

ini_set('memory_limit', K_MAX_MEMORY_LIMIT); // set PHP memory limit
ini_set('session.use_trans_sid', 0); // if =1 use PHPSESSID (for clients that do not support cookies)

//============================================================+
// END OF FILE
//============================================================+
