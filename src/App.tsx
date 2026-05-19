import { lazy, Suspense } from 'react'
import { Routes, Route, Navigate, useParams } from 'react-router-dom'
import { Landing } from './pages/Landing'
import { Library } from './pages/Library'
import { ToolDetail } from './pages/ToolDetail'
import { Saved } from './pages/Saved'
import { Claude } from './pages/Claude'

const Admin = lazy(() => import('./pages/Admin').then(m => ({ default: m.Admin })))
import { AuthProvider } from './contexts/AuthContext'
import { DownloadsProvider } from './contexts/DownloadsContext'
import { BookmarksProvider } from './contexts/BookmarksContext'
import { ToolsProvider } from './contexts/ToolsContext'
import { AuthModal } from './components/AuthModal'
import { ScrollToTop } from './components/ScrollToTop'

export default function App() {
  return (
    <AuthProvider>
      <ToolsProvider>
        <DownloadsProvider>
          <BookmarksProvider>
            <ScrollToTop />
            <Routes>
              <Route path="/" element={<Landing />} />
              <Route path="/bat" element={<Library />} />
              <Route path="/bat/:id" element={<ToolDetail />} />
              <Route path="/saved" element={<Saved />} />
              <Route path="/claude" element={<Claude />} />
              <Route path="/admin" element={<Suspense fallback={null}><Admin /></Suspense>} />
              <Route path="/tool/:id" element={<LegacyToolRedirect />} />
            </Routes>
            <AuthModal />
          </BookmarksProvider>
        </DownloadsProvider>
      </ToolsProvider>
    </AuthProvider>
  )
}

function LegacyToolRedirect() {
  const { id } = useParams<{ id: string }>()
  return <Navigate to={`/bat/${id}`} replace />
}
