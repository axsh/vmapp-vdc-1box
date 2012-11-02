-- MySQL dump 10.13  Distrib 5.1.61, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: wakame_dcmgr
-- ------------------------------------------------------
-- Server version	5.1.61

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounting_logs`
--

DROP TABLE IF EXISTS `accounting_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounting_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `resource_type` varchar(255) NOT NULL,
  `event_type` varchar(255) NOT NULL,
  `vchar_value` varchar(255) DEFAULT NULL,
  `int_value` bigint(20) DEFAULT NULL,
  `blob_value` blob,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `uuid` (`uuid`),
  KEY `accounting_logs_account_id_index` (`account_id`),
  KEY `accounting_logs_resource_type_index` (`resource_type`),
  KEY `accounting_logs_event_type_index` (`event_type`),
  KEY `accounting_logs_created_at_index` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounting_logs`
--

LOCK TABLES `accounting_logs` WRITE;
/*!40000 ALTER TABLE `accounting_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounting_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `purged_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `accounts_deleted_at_index` (`deleted_at`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (100,'00000000','datacenter system account',1,'2012-10-25 07:07:46','2012-10-25 07:07:46',NULL,NULL),(101,'shpoolxx','system account for shared resources',1,'2012-10-25 07:07:46','2012-10-25 07:07:46',NULL,NULL);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_objects`
--

DROP TABLE IF EXISTS `backup_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `backup_storage_id` int(11) NOT NULL,
  `size` bigint(20) NOT NULL,
  `allocation_size` bigint(20) NOT NULL,
  `container_format` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `state` varchar(255) NOT NULL DEFAULT 'initialized',
  `object_key` varchar(255) NOT NULL,
  `checksum` varchar(255) NOT NULL,
  `description` text,
  `progress` double NOT NULL DEFAULT '0',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `purged_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `backup_objects_account_id_index` (`account_id`),
  KEY `backup_objects_deleted_at_index` (`deleted_at`),
  KEY `backup_objects_backup_storage_id_index` (`backup_storage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_objects`
--

LOCK TABLES `backup_objects` WRITE;
/*!40000 ALTER TABLE `backup_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `backup_storages`
--

DROP TABLE IF EXISTS `backup_storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `backup_storages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `storage_type` varchar(255) NOT NULL,
  `description` text,
  `base_uri` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `backup_storages`
--

LOCK TABLES `backup_storages` WRITE;
/*!40000 ALTER TABLE `backup_storages` DISABLE KEYS */;
/*!40000 ALTER TABLE `backup_storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dc_networks`
--

DROP TABLE IF EXISTS `dc_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dc_networks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `vlan_lease_id` int(11) DEFAULT NULL,
  `offering_network_modes` text NOT NULL,
  `allow_new_networks` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `physical_networks_name_index` (`name`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dc_networks`
--

LOCK TABLES `dc_networks` WRITE;
/*!40000 ALTER TABLE `dc_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `dc_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhcp_ranges`
--

DROP TABLE IF EXISTS `dhcp_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhcp_ranges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_id` int(11) NOT NULL,
  `range_begin` int(11) unsigned NOT NULL,
  `range_end` int(11) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dhcp_ranges_network_id_index` (`network_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhcp_ranges`
--

LOCK TABLES `dhcp_ranges` WRITE;
/*!40000 ALTER TABLE `dhcp_ranges` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhcp_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frontend_systems`
--

DROP TABLE IF EXISTS `frontend_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frontend_systems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kind` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `credential` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frontend_systems`
--

LOCK TABLES `frontend_systems` WRITE;
/*!40000 ALTER TABLE `frontend_systems` DISABLE KEYS */;
/*!40000 ALTER TABLE `frontend_systems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `histories`
--

DROP TABLE IF EXISTS `histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `attr` varchar(255) NOT NULL,
  `vchar_value` varchar(255) DEFAULT NULL,
  `blob_value` text,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `histories_uuid_attr_index` (`uuid`,`attr`),
  KEY `histories_uuid_created_at_index` (`uuid`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `histories`
--

LOCK TABLES `histories` WRITE;
/*!40000 ALTER TABLE `histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_node_vnets`
--

DROP TABLE IF EXISTS `host_node_vnets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_node_vnets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host_node_id` int(11) NOT NULL,
  `network_id` int(11) NOT NULL,
  `broadcast_addr` varchar(12) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host_node_vnets_host_node_id_index` (`host_node_id`),
  KEY `host_node_vnets_network_id_index` (`network_id`),
  KEY `host_node_vnets_broadcast_addr_index` (`broadcast_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_node_vnets`
--

LOCK TABLES `host_node_vnets` WRITE;
/*!40000 ALTER TABLE `host_node_vnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_node_vnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_nodes`
--

DROP TABLE IF EXISTS `host_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `node_id` varchar(255) DEFAULT NULL,
  `arch` varchar(255) NOT NULL,
  `hypervisor` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `offering_cpu_cores` int(11) NOT NULL,
  `offering_memory_size` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `host_nodes_node_id_index` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_nodes`
--

LOCK TABLES `host_nodes` WRITE;
/*!40000 ALTER TABLE `host_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostname_leases`
--

DROP TABLE IF EXISTS `hostname_leases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostname_leases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `hostname` varchar(32) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname_leases_account_id_hostname_index` (`account_id`,`hostname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostname_leases`
--

LOCK TABLES `hostname_leases` WRITE;
/*!40000 ALTER TABLE `hostname_leases` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostname_leases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `boot_dev_type` int(11) NOT NULL DEFAULT '1',
  `arch` varchar(255) NOT NULL,
  `description` text,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `state` varchar(255) NOT NULL DEFAULT 'init',
  `features` text,
  `file_format` varchar(255) NOT NULL,
  `root_device` varchar(255) DEFAULT NULL,
  `is_cacheable` tinyint(1) NOT NULL DEFAULT '0',
  `instance_model_name` varchar(255) NOT NULL,
  `parent_image_id` varchar(255) DEFAULT NULL,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `backup_object_id` varchar(255) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `images_account_id_index` (`account_id`),
  KEY `images_is_public_index` (`is_public`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance_specs`
--

DROP TABLE IF EXISTS `instance_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `hypervisor` varchar(255) NOT NULL,
  `arch` varchar(255) NOT NULL,
  `cpu_cores` int(11) NOT NULL,
  `memory_size` int(11) NOT NULL,
  `quota_weight` double NOT NULL DEFAULT '1',
  `vifs` text,
  `drives` text,
  `config` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `instance_specs_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_specs`
--

LOCK TABLES `instance_specs` WRITE;
/*!40000 ALTER TABLE `instance_specs` DISABLE KEYS */;
/*!40000 ALTER TABLE `instance_specs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instances`
--

DROP TABLE IF EXISTS `instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `host_node_id` int(11) DEFAULT NULL,
  `image_id` int(11) NOT NULL,
  `state` varchar(255) NOT NULL DEFAULT 'init',
  `status` varchar(255) NOT NULL DEFAULT 'init',
  `hostname` varchar(32) NOT NULL,
  `ssh_key_pair_id` varchar(255) DEFAULT NULL,
  `ha_enabled` int(11) NOT NULL DEFAULT '0',
  `quota_weight` double NOT NULL DEFAULT '0',
  `cpu_cores` int(11) NOT NULL,
  `memory_size` int(11) NOT NULL,
  `user_data` text NOT NULL,
  `runtime_config` text NOT NULL,
  `ssh_key_data` text,
  `request_params` text NOT NULL,
  `terminated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `hypervisor` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `instances_account_id_index` (`account_id`),
  KEY `instances_host_node_id_index` (`host_node_id`),
  KEY `instances_state_index` (`state`),
  KEY `instances_terminated_at_index` (`terminated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instances`
--

LOCK TABLES `instances` WRITE;
/*!40000 ALTER TABLE `instances` DISABLE KEYS */;
/*!40000 ALTER TABLE `instances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ip_leases`
--

DROP TABLE IF EXISTS `ip_leases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip_leases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_id` int(11) NOT NULL,
  `ipv4` int(11) unsigned DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_leases_network_id_ipv4_index` (`network_id`,`ipv4`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ip_leases`
--

LOCK TABLES `ip_leases` WRITE;
/*!40000 ALTER TABLE `ip_leases` DISABLE KEYS */;
/*!40000 ALTER TABLE `ip_leases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_states`
--

DROP TABLE IF EXISTS `job_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` varchar(80) NOT NULL,
  `parent_job_id` varchar(80) DEFAULT NULL,
  `node_id` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `session_id` varchar(80) DEFAULT NULL,
  `job_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `job_states_job_id_index` (`job_id`),
  KEY `job_states_session_id_index` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_states`
--

LOCK TABLES `job_states` WRITE;
/*!40000 ALTER TABLE `job_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancer_targets`
--

DROP TABLE IF EXISTS `load_balancer_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancer_targets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_vif_id` varchar(255) NOT NULL,
  `load_balancer_id` int(11) NOT NULL,
  `fallback_mode` varchar(255) NOT NULL DEFAULT 'off',
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `is_deleted` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `load_balancer_targets_load_balancer_id_network_vif_id_index` (`load_balancer_id`,`network_vif_id`,`is_deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancer_targets`
--

LOCK TABLES `load_balancer_targets` WRITE;
/*!40000 ALTER TABLE `load_balancer_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancer_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `load_balancers`
--

DROP TABLE IF EXISTS `load_balancers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `load_balancers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `account_id` varchar(255) NOT NULL,
  `instance_id` int(11) NOT NULL,
  `protocol` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `instance_protocol` varchar(255) NOT NULL,
  `instance_port` int(11) NOT NULL,
  `balance_algorithm` varchar(255) NOT NULL,
  `cookie_name` varchar(255) DEFAULT NULL,
  `description` text,
  `private_key` text,
  `public_key` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `load_balancers_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `load_balancers`
--

LOCK TABLES `load_balancers` WRITE;
/*!40000 ALTER TABLE `load_balancers` DISABLE KEYS */;
/*!40000 ALTER TABLE `load_balancers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mac_leases`
--

DROP TABLE IF EXISTS `mac_leases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mac_leases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mac_addr` bigint(20) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mac_leases_mac_addr_index` (`mac_addr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mac_leases`
--

LOCK TABLES `mac_leases` WRITE;
/*!40000 ALTER TABLE `mac_leases` DISABLE KEYS */;
/*!40000 ALTER TABLE `mac_leases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mac_ranges`
--

DROP TABLE IF EXISTS `mac_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mac_ranges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `vendor_id` mediumint(8) unsigned NOT NULL,
  `range_begin` mediumint(8) unsigned NOT NULL,
  `range_end` mediumint(8) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mac_ranges`
--

LOCK TABLES `mac_ranges` WRITE;
/*!40000 ALTER TABLE `mac_ranges` DISABLE KEYS */;
/*!40000 ALTER TABLE `mac_ranges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_services`
--

DROP TABLE IF EXISTS `network_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_vif_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `incoming_port` int(11) DEFAULT NULL,
  `outgoing_port` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_services_network_vif_id_name_index` (`network_vif_id`,`name`),
  KEY `network_services_network_vif_id_index` (`network_vif_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_services`
--

LOCK TABLES `network_services` WRITE;
/*!40000 ALTER TABLE `network_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_vif_ip_leases`
--

DROP TABLE IF EXISTS `network_vif_ip_leases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_vif_ip_leases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_id` int(11) NOT NULL,
  `network_vif_id` int(11) NOT NULL,
  `ipv4` int(11) unsigned NOT NULL,
  `alloc_type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `is_deleted` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_vif_ip_leases_network_id_network_vif_id_ipv4_index` (`network_id`,`network_vif_id`,`ipv4`,`is_deleted`),
  KEY `network_vif_ip_leases_updated_at_index` (`updated_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_vif_ip_leases`
--

LOCK TABLES `network_vif_ip_leases` WRITE;
/*!40000 ALTER TABLE `network_vif_ip_leases` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_vif_ip_leases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_vif_monitors`
--

DROP TABLE IF EXISTS `network_vif_monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_vif_monitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `network_vif_id` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `protocol` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `params` text NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `network_vif_monitors_deleted_at_index` (`deleted_at`),
  KEY `network_vif_monitors_network_vif_id_index` (`network_vif_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_vif_monitors`
--

LOCK TABLES `network_vif_monitors` WRITE;
/*!40000 ALTER TABLE `network_vif_monitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_vif_monitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_vif_security_groups`
--

DROP TABLE IF EXISTS `network_vif_security_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_vif_security_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_vif_id` int(11) NOT NULL,
  `security_group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `network_vif_security_groups_network_vif_id_index` (`network_vif_id`),
  KEY `network_vif_security_groups_security_group_id_index` (`security_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_vif_security_groups`
--

LOCK TABLES `network_vif_security_groups` WRITE;
/*!40000 ALTER TABLE `network_vif_security_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_vif_security_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `network_vifs`
--

DROP TABLE IF EXISTS `network_vifs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `network_vifs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `instance_id` int(11) DEFAULT NULL,
  `network_id` int(11) DEFAULT NULL,
  `nat_network_id` int(11) DEFAULT NULL,
  `mac_addr` varchar(12) NOT NULL,
  `device_index` int(11) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `account_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `instance_nics_deleted_at_index` (`deleted_at`),
  KEY `instance_nics_instance_id_index` (`instance_id`),
  KEY `instance_nics_mac_addr_index` (`mac_addr`),
  KEY `network_vifs_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `network_vifs`
--

LOCK TABLES `network_vifs` WRITE;
/*!40000 ALTER TABLE `network_vifs` DISABLE KEYS */;
/*!40000 ALTER TABLE `network_vifs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `ipv4_network` varchar(255) NOT NULL,
  `ipv4_gw` varchar(255) DEFAULT NULL,
  `prefix` int(11) NOT NULL DEFAULT '24',
  `metric` int(11) NOT NULL DEFAULT '100',
  `domain_name` varchar(255) DEFAULT NULL,
  `dns_server` varchar(255) DEFAULT NULL,
  `dhcp_server` varchar(255) DEFAULT NULL,
  `metadata_server` varchar(255) DEFAULT NULL,
  `metadata_server_port` int(11) DEFAULT NULL,
  `nat_network_id` int(11) DEFAULT NULL,
  `dc_network_id` int(11) DEFAULT NULL,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `gateway_network_id` int(11) DEFAULT NULL,
  `network_mode` varchar(255) NOT NULL,
  `bandwidth` float DEFAULT NULL,
  `ip_assignment` varchar(255) NOT NULL DEFAULT 'asc',
  `editable` tinyint(1) NOT NULL DEFAULT '0',
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `networks_account_id_index` (`account_id`),
  KEY `networks_nat_network_id_index` (`nat_network_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_states`
--

DROP TABLE IF EXISTS `node_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` varchar(80) NOT NULL,
  `boot_token` varchar(10) NOT NULL,
  `state` varchar(10) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `last_ping_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_states_node_id_index` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_states`
--

LOCK TABLES `node_states` WRITE;
/*!40000 ALTER TABLE `node_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_logs`
--

DROP TABLE IF EXISTS `request_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_id` varchar(40) NOT NULL,
  `frontend_system_id` varchar(40) NOT NULL,
  `account_id` varchar(40) NOT NULL,
  `requester_token` varchar(255) DEFAULT NULL,
  `request_method` varchar(10) NOT NULL,
  `api_path` varchar(255) NOT NULL,
  `params` text NOT NULL,
  `response_status` int(11) NOT NULL,
  `response_msg` text,
  `requested_at` datetime NOT NULL,
  `requested_at_usec` int(11) NOT NULL,
  `responded_at` datetime NOT NULL,
  `responded_at_usec` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `request_id` (`request_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_logs`
--

LOCK TABLES `request_logs` WRITE;
/*!40000 ALTER TABLE `request_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `request_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_info` (
  `version` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_info`
--

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (1);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_group_references`
--

DROP TABLE IF EXISTS `security_group_references`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_group_references` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referencer_id` int(11) NOT NULL,
  `referencee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `security_group_references_referencer_id_index` (`referencer_id`),
  KEY `security_group_references_referencee_id_index` (`referencee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_group_references`
--

LOCK TABLES `security_group_references` WRITE;
/*!40000 ALTER TABLE `security_group_references` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_group_references` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `security_groups`
--

DROP TABLE IF EXISTS `security_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `rule` text,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `security_groups_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `security_groups`
--

LOCK TABLES `security_groups` WRITE;
/*!40000 ALTER TABLE `security_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `security_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ssh_key_pairs`
--

DROP TABLE IF EXISTS `ssh_key_pairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ssh_key_pairs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` char(8) NOT NULL,
  `finger_print` varchar(100) NOT NULL,
  `public_key` text NOT NULL,
  `private_key` text,
  `description` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `ssh_key_pairs_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ssh_key_pairs`
--

LOCK TABLES `ssh_key_pairs` WRITE;
/*!40000 ALTER TABLE `ssh_key_pairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ssh_key_pairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storage_nodes`
--

DROP TABLE IF EXISTS `storage_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `storage_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `node_id` varchar(255) NOT NULL,
  `export_path` varchar(255) NOT NULL,
  `offering_disk_space_mb` int(11) NOT NULL,
  `transport_type` varchar(255) NOT NULL,
  `storage_type` varchar(255) NOT NULL,
  `ipaddr` varchar(255) NOT NULL,
  `snapshot_base_path` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `storage_nodes_node_id_index` (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storage_nodes`
--

LOCK TABLES `storage_nodes` WRITE;
/*!40000 ALTER TABLE `storage_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `storage_nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_mappings`
--

DROP TABLE IF EXISTS `tag_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_mappings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `sort_index` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tag_mappings_tag_id_index` (`tag_id`),
  KEY `tag_mappings_uuid_index` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_mappings`
--

LOCK TABLES `tag_mappings` WRITE;
/*!40000 ALTER TABLE `tag_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tag_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags_account_id_type_id_name_index` (`account_id`,`type_id`,`name`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `tags_account_id_index` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'a-shpoolxx','shhost',11,'default_shared_hosts',NULL,'2012-10-25 07:07:46','2012-10-25 07:07:46'),(2,'a-shpoolxx','shnet',10,'default_shared_networks',NULL,'2012-10-25 07:07:46','2012-10-25 07:07:46'),(3,'a-shpoolxx','shstor',12,'default_shared_storage',NULL,'2012-10-25 07:07:46','2012-10-25 07:07:46');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vlan_leases`
--

DROP TABLE IF EXISTS `vlan_leases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vlan_leases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `dc_network_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  UNIQUE KEY `vlan_leases_dc_network_id_tag_id_index` (`dc_network_id`,`tag_id`),
  KEY `vlan_leases_account_id_index` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vlan_leases`
--

LOCK TABLES `vlan_leases` WRITE;
/*!40000 ALTER TABLE `vlan_leases` DISABLE KEYS */;
/*!40000 ALTER TABLE `vlan_leases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volume_snapshots`
--

DROP TABLE IF EXISTS `volume_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volume_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `storage_node_id` int(11) NOT NULL,
  `origin_volume_id` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `state` varchar(255) NOT NULL DEFAULT 'initialized',
  `destination_key` varchar(255) NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `volume_snapshots_account_id_index` (`account_id`),
  KEY `volume_snapshots_deleted_at_index` (`deleted_at`),
  KEY `volume_snapshots_storage_node_id_index` (`storage_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volume_snapshots`
--

LOCK TABLES `volume_snapshots` WRITE;
/*!40000 ALTER TABLE `volume_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `volume_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` varchar(255) NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `storage_node_id` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'initialized',
  `state` varchar(255) NOT NULL DEFAULT 'initialized',
  `size` bigint(20) NOT NULL,
  `instance_id` int(11) DEFAULT NULL,
  `boot_dev` int(11) NOT NULL DEFAULT '0',
  `host_device_name` varchar(255) DEFAULT NULL,
  `guest_device_name` varchar(255) DEFAULT NULL,
  `export_path` varchar(255) NOT NULL,
  `transport_information` text,
  `request_params` text NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `attached_at` datetime DEFAULT NULL,
  `detached_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `service_type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `backup_object_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `volumes_account_id_index` (`account_id`),
  KEY `volumes_deleted_at_index` (`deleted_at`),
  KEY `volumes_instance_id_index` (`instance_id`),
  KEY `volumes_storage_node_id_index` (`storage_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-10-25 16:08:19
