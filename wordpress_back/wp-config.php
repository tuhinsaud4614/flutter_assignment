<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpbdb' );

/** MySQL database username */
define( 'DB_USER', 'wordpress' );

/** MySQL database password */
define( 'DB_PASSWORD', 'Wordpress_123' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'Ho|[H6!Mmt5d}]:Q/kB,UDz)}QY<$.ES=^>f1^Bg*u2dm}Ys*j0dt9B=Wj(%^SM!' );
define( 'SECURE_AUTH_KEY',  ',ix:0ghJATDIYlIar03gTA4Jk/^mAuip{~*m=_y1J[}HeOXU[m,7mA1+.+*1!Ai?' );
define( 'LOGGED_IN_KEY',    'Mb}n`v{U(-[QS3-8~?+,+^g2kh3H# 54gyyXt7%S2e>}}U@FCGp=G7/5;zqtd}@R' );
define( 'NONCE_KEY',        'nnf:HA;ImfwKmiWrU*5^wsAEBr]7.,kD4dL3xZuvip~h9fe%e;JXX-<1Bz6{d^V1' );
define( 'AUTH_SALT',        'Hyv~O2pApe;{d~7#$3Z)|}d7Wj..*g8=0savSpb5eW8gkZ%~Jva?-I:Osd.k~`on' );
define( 'SECURE_AUTH_SALT', ',IkAUUr4PA01LLezV`lO6Ye3SB)nK^s%*Z@eZpJ}i6t$r_m-q564 mX%>1QgVS(G' );
define( 'LOGGED_IN_SALT',   'A*>ChHrm@JTG7jx]}9@&<WS,m7OwxllIBRJ3;l~3:,@B=xJfcq47[WyrN[Zl@G@_' );
define( 'NONCE_SALT',       'Z{=,E:[VulaaKfHM6GLfa%Z^WcTZoe5.k{Fb]N6;vFN>Mp:eXd#Zt[79W|gc2ekO' );

define('JWT_AUTH_SECRET_KEY', 'Idy+w 2|+-zLy)z=><SO2IS+nZ*e2djf{)DupL^%Hoo7`Q^=V91T4^,(b(E1*+)O');
define('JWT_AUTH_CORS_ENABLE', true);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wpb_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
