
CREATE DATABASE IF NOT EXISTS db_sekolah;
USE db_sekolah;

-- 1. Tabel Entitas Guru
DROP TABLE IF EXISTS mengajar;
DROP TABLE IF EXISTS mata_pelajaran;
DROP TABLE IF EXISTS guru;

CREATE TABLE guru (
    kode_guru VARCHAR(10) PRIMARY KEY,
    nama_guru VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabel Entitas Mata Pelajaran
CREATE TABLE mata_pelajaran (
    kode_matpel VARCHAR(10) PRIMARY KEY,
    nama_matpel VARCHAR(100) NOT NULL,
    jumlah_jam INT NOT NULL,
    semester ENUM('Ganjil', 'Genap') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel Relasi Mengajar (Menghubungkan Guru dan Mata Pelajaran dengan atribut tambahan)
CREATE TABLE mengajar (
    id_mengajar INT AUTO_INCREMENT PRIMARY KEY,
    kode_guru VARCHAR(10) NOT NULL,
    kode_matpel VARCHAR(10) NOT NULL,
    ruang VARCHAR(20) NOT NULL,
    jam_ke VARCHAR(20) NOT NULL,
    CONSTRAINT fk_mengajar_guru 
        FOREIGN KEY (kode_guru) REFERENCES guru(kode_guru) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_mengajar_matpel 
        FOREIGN KEY (kode_matpel) REFERENCES mata_pelajaran(kode_matpel) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ========================================================
-- Contoh Data Dummy (DML)
-- ========================================================

-- Insert data Guru
INSERT INTO guru (kode_guru, nama_guru) VALUES
('G001', 'Budi Santoso, S.Kom.'),
('G002', 'Siti Rahmawati, S.Pd.'),
('G003', 'Ahmad Fauzi, M.T.');

-- Insert data Mata Pelajaran
INSERT INTO mata_pelajaran (kode_matpel, nama_matpel, jumlah_jam, semester) VALUES
('MP01', 'Pemodelan Perangkat Lunak', 4, 'Ganjil'),
('MP02', 'Basis Data', 4, 'Ganjil'),
('MP03', 'Pemrograman Web dan Perangkat Bergerak', 6, 'Genap'),
('MP04', 'Administrasi Sistem Jaringan', 4, 'Ganjil');

-- Insert relasi Mengajar (Membuktikan relasi 1 to Many: 1 guru bisa mengajar beberapa mata pelajaran)
-- Guru G001 mengajar MP01 dan MP02
INSERT INTO mengajar (kode_guru, kode_matpel, ruang, jam_ke) VALUES
('G001', 'MP01', 'Lab RPL 1', '1 - 4'),
('G001', 'MP02', 'Lab RPL 2', '5 - 8'),
('G002', 'MP03', 'Lab RPL 1', '1 - 6'),
('G003', 'MP04', 'Lab TKJ 1', '1 - 4');

-- ========================================================
-- Query Pengujian (Menampilkan data jadwal mengajar secara lengkap)
-- ========================================================
SELECT 
    m.id_mengajar,
    g.kode_guru,
    g.nama_guru,
    mp.kode_matpel,
    mp.nama_matpel,
    mp.jumlah_jam,
    mp.semester,
    m.ruang,
    m.jam_ke
FROM mengajar m
JOIN guru g ON m.kode_guru = g.kode_guru
JOIN mata_pelajaran mp ON m.kode_matpel = mp.kode_matpel
ORDER BY g.nama_guru, m.jam_ke;
