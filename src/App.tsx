import { Routes, Route } from 'react-router-dom'
import { Index } from './pages/Index'
import { ToolDetail } from './pages/ToolDetail'

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Index />} />
      <Route path="/tool/:id" element={<ToolDetail />} />
    </Routes>
  )
}
